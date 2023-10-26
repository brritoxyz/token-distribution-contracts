// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {TokenClaims} from "src/TokenClaims.sol";

contract RumasSetOwners is
    TokenClaims(
        // Reference: https://github.com/jpvge/token-distribution/blob/main/src/claimData/setOwners.json#L2.
        0x92b0cf42ab25ed7a1ae1082183456198dadbae389e5687ae84f3f921385b7817
    )
{}
