// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import {LibString} from "solady/utils/LibString.sol";
import {SafeTransferLib} from "solady/utils/SafeTransferLib.sol";
import {TokenClaims} from "src/TokenClaims.sol";

contract TokenClaimsHelper is Test {
    using LibString for uint256;
    using SafeTransferLib for address;

    address public constant BRR = 0x6d80d90ce251985bF41A98c6FDd6b7b975Fff884;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    function _getProofsKeys(
        string memory file
    ) internal pure returns (string[] memory) {
        return vm.parseJsonKeys(file, ".proofs");
    }

    function _getProofs(
        string memory file,
        string memory key
    ) internal pure returns (bytes32[] memory) {
        return
            vm.parseJsonBytes32Array(
                file,
                string.concat('.proofs["', key, '"]')
            );
    }

    function _getClaimerAndAmount(
        string memory file,
        uint256 index
    ) internal pure returns (address, uint256) {
        string memory indexStr = index.toString();

        return (
            vm.parseJsonAddress(
                file,
                string.concat(".data[", indexStr, "][0]")
            ),
            vm.parseJsonUint(file, string.concat(".data[", indexStr, "][1]"))
        );
    }

    function _cannotClaimAlreadyClaimed(
        TokenClaims tokenClaims,
        bytes32[] memory proofs,
        address claimer,
        uint256 amount
    ) internal {
        vm.prank(claimer);
        vm.expectRevert(TokenClaims.AlreadyClaimed.selector);

        tokenClaims.claim(proofs, amount);
    }
}
