// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {TokenClaims} from "src/TokenClaims.sol";

contract RumasUniqueOwners is
    TokenClaims(
        // Reference: https://github.com/jpvge/token-distribution/blob/main/src/claimData/uniqueOwners.json#L2.
        0x7f8848a9849b6bd9137dcf9f2037eaf69414a8b08703f79bd0720de1db601512
    )
{}
