// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import {LibString} from "solady/utils/LibString.sol";
import {SafeTransferLib} from "solady/utils/SafeTransferLib.sol";
import {RumasSetOwners} from "src/RumasSetOwners.sol";
import {TokenClaims} from "src/TokenClaims.sol";
import {TokenClaimsHelper} from "test/TokenClaimsHelper.sol";

contract RumasSetOwnersTest is Test, TokenClaimsHelper {
    using SafeTransferLib for address;

    RumasSetOwners public immutable tokenClaims = new RumasSetOwners();
    string public file = vm.readFile("test/claimData/setOwners.json");

    function testCannotClaimInvalidProof() external {
        string[] memory keys = _getProofsKeys(file);
        uint256 keysLength = keys.length;

        for (uint256 i = 0; i < keysLength; ) {
            bytes32[] memory proofs = _getProofs(file, keys[i]);
            (address claimer, uint256 amount) = _getClaimerAndAmount(file, i);
            proofs[0] = keccak256(abi.encode(proofs[0]));

            vm.prank(claimer);
            vm.expectRevert(TokenClaims.InvalidProof.selector);

            tokenClaims.claim(proofs, amount);

            unchecked {
                ++i;
            }
        }
    }

    function testClaim() external {
        string[] memory keys = _getProofsKeys(file);
        uint256 keysLength = keys.length;

        deal(BRR, address(tokenClaims), 1);

        for (uint256 i = 0; i < keysLength; ) {
            bytes32[] memory proofs = _getProofs(file, keys[i]);
            (address claimer, uint256 amount) = _getClaimerAndAmount(file, i);
            uint256 balanceBefore = BRR.balanceOf(claimer);

            // Ensure there's enough BRR to fulfill claim.
            deal(BRR, address(tokenClaims), amount);

            assertEq(0, tokenClaims.claims(claimer));

            vm.prank(claimer);
            vm.expectEmit(true, true, false, true, BRR);

            emit Transfer(address(tokenClaims), claimer, amount);

            tokenClaims.claim(proofs, amount);

            assertEq(balanceBefore + amount, BRR.balanceOf(claimer));
            assertEq(amount, tokenClaims.claims(claimer));

            _cannotClaimAlreadyClaimed(tokenClaims, proofs, claimer, amount);

            unchecked {
                ++i;
            }
        }
    }
}
