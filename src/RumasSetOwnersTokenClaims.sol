// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {TokenClaims} from "src/TokenClaims.sol";

contract RumasSetOwnersTokenClaims is
    TokenClaims(
        // Reference: https://github.com/jpvge/token-distribution/blob/main/src/claimData/setOwners.json#L2.
        0x86426c408007493c26bc446e1164e01a14d83dc7c23c1ca077795f753601a9dd
    )
{}
