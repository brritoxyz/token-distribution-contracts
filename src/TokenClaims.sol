// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {MerkleProofLib} from "solady/utils/MerkleProofLib.sol";
import {SafeTransferLib} from "solady/utils/SafeTransferLib.sol";

/**
 * @title Token claims that make use of merkle proofs for verifying claim eligibility.
 * @notice Based on my prior work: https://github.com/kphed/anfd-merkle-claims.
 * @author kphed (GitHub) / ppmoon69 (Twitter)
 */
contract TokenClaims {
    using MerkleProofLib for bytes32[];
    using SafeTransferLib for address;

    address public constant BRR = 0x6d80d90ce251985bF41A98c6FDd6b7b975Fff884;
    bytes32 public immutable merkleRoot;

    mapping(address claimer => uint256 amount) public claims;

    error InvalidProof();
    error AlreadyClaimed();

    constructor(bytes32 _merkleRoot) {
        merkleRoot = _merkleRoot;
    }

    /**
     * @notice Claim BRR tokens.
     * @param  proof   bytes32[]  Merkle proof.
     * @param  amount  uint256    Claim amount.
     */
    function claim(bytes32[] calldata proof, uint256 amount) external {
        if (claims[msg.sender] != 0) revert AlreadyClaimed();
        if (
            !proof.verifyCalldata(
                merkleRoot,
                // Compute the leaf using constituent data (i.e. msg.sender/claimer address)
                // https://github.com/OpenZeppelin/merkle-tree#validating-a-proof-in-solidity.
                keccak256(
                    bytes.concat(keccak256(abi.encode(msg.sender, amount)))
                )
            )
        ) revert InvalidProof();

        // Prevent double claiming.
        claims[msg.sender] = amount;

        // Emits the `Transfer` event which can be used to index claims.
        BRR.safeTransfer(msg.sender, amount);
    }
}
