// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {TokenClaims} from "src/TokenClaims.sol";

contract RumasUniqueOwnersTokenClaims is
    TokenClaims(
        // Reference: https://github.com/jpvge/token-distribution/blob/main/src/claimData/uniqueOwners.json#L2.
        0x32a1a929c0ea3d5d0b3e35cd023e6783660a1b20ad923ca37c01b869de2bbb69
    )
{}
