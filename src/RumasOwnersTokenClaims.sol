// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {TokenClaims} from "src/TokenClaims.sol";

contract RumasOwnersTokenClaims is
    TokenClaims(
        // Reference: https://github.com/jpvge/token-distribution/blob/main/src/claimData/owners.json#L2.
        0xd98f0a607c389602f98fbf3017d531f53d8f658eb24bc633fb508728653db807
    )
{}
