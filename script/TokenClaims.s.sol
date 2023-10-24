// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import {BetaTesters} from "src/BetaTesters.sol";
import {RumasOwners} from "src/RumasOwners.sol";
import {RumasSetOwners} from "src/RumasSetOwners.sol";
import {RumasUniqueOwners} from "src/RumasUniqueOwners.sol";

contract TokenClaimsScript is Script {
    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        new BetaTesters();
        new RumasOwners();
        new RumasSetOwners();
        new RumasUniqueOwners();

        vm.stopBroadcast();
    }
}
