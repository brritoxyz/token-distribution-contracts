// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {TokenClaims} from "src/TokenClaims.sol";

contract BetaTestersTokenClaims is
    TokenClaims(
        // Reference: https://github.com/jpvge/token-distribution/blob/main/src/claimData/testers.json#L2.
        0x8225cf009b346b5689b87599e89430cf160330a9e9c07f519f9c2cffd92221d4
    )
{}
