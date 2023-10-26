// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {TokenClaims} from "src/TokenClaims.sol";

contract RumasOwners is
    TokenClaims(
        // Reference: https://github.com/jpvge/token-distribution/blob/main/src/claimData/owners.json#L2.
        0x0781c291694c4774e48c7b5558f0938524482c11a1e530e31607b35d030fc577
    )
{}
