// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {TokenClaims} from "src/TokenClaims.sol";

contract BetaTesters is
    TokenClaims(
        // Reference: https://github.com/jpvge/token-distribution/blob/main/src/claimData/testers.json#L2.
        0xdb4f3bdd5dc9b05de3bed89feb77625fa1d982359de30db6f0757e14bdb5071a
    )
{}
