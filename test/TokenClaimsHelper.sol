// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Test.sol";
import {LibString} from "solady/utils/LibString.sol";

contract TokenClaimsHelper is Test {
    using LibString for uint256;

    function _getProofsKeys(
        string memory file
    ) private pure returns (string[] memory) {
        return vm.parseJsonKeys(file, ".proofs");
    }

    function _getProofs(
        string memory file,
        string memory key
    ) private pure returns (bytes32[] memory) {
        return
            vm.parseJsonBytes32Array(
                file,
                string.concat('.proofs["', key, '"]')
            );
    }

    function _getClaimerAndAmount(
        string memory file,
        uint256 index
    ) private pure returns (address, uint256) {
        string memory indexStr = index.toString();

        return (
            vm.parseJsonAddress(
                file,
                string.concat(".data[", indexStr, "][0]")
            ),
            vm.parseJsonUint(file, string.concat(".data[", indexStr, "][1]"))
        );
    }
}
