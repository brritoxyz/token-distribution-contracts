// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import {LibString} from "solady/utils/LibString.sol";
import {SafeTransferLib} from "solady/utils/SafeTransferLib.sol";
import {RumasOwners} from "src/RumasOwners.sol";
import {TokenClaims} from "src/TokenClaims.sol";
import {TokenClaimsHelper} from "test/TokenClaimsHelper.sol";

contract RumasOwnersTest is Test, TokenClaimsHelper {
    using SafeTransferLib for address;

    RumasOwners public immutable tokenClaims = new RumasOwners();
    string public file = vm.readFile("test/claimData/owners.json");

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
        // Prevent OOG error.
        vm.pauseGasMetering();

        string[] memory keys = _getProofsKeys(file);
        uint256 keysLength = keys.length;

        deal(_BRR, address(tokenClaims), 1);

        for (uint256 i = 0; i < keysLength; ) {
            bytes32[] memory proofs = _getProofs(file, keys[i]);
            (address claimer, uint256 amount) = _getClaimerAndAmount(file, i);
            uint256 balanceBefore = _BRR.balanceOf(claimer);

            // Ensure there's enough BRR to fulfill claim.
            deal(_BRR, address(tokenClaims), amount);

            assertEq(0, tokenClaims.claims(claimer));

            vm.prank(claimer);
            vm.expectEmit(true, true, false, true, _BRR);

            emit Transfer(address(tokenClaims), claimer, amount);

            tokenClaims.claim(proofs, amount);

            assertEq(balanceBefore + amount, _BRR.balanceOf(claimer));
            assertEq(amount, tokenClaims.claims(claimer));

            _cannotClaimAlreadyClaimed(tokenClaims, proofs, claimer, amount);

            unchecked {
                ++i;
            }
        }
    }
}
