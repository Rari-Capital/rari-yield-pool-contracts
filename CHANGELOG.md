# Changelog

## `v1.2.0` (contracts deployed 2020-11-25; all code pushed 2020-11-29)

* Fixed bug in validation of mUSD redemption in `RariFundController.withdrawAndExchange`.

## `v1.1.0` (contracts deployed 2020-11-19; all code pushed 2020-11-24)

* Added 0.5% withdrawal fee (removing `RariFundManager.withdrawFees` to save gas).

## `v1.0.0` (contracts deployed 2020-10-20; all code pushed 2020-10-30)

* Copied Rari Stable Pool `v2.0.0` at commit [8a0405e](https://github.com/Rari-Capital/rari-stable-pool-contracts/commit/8a0405e8dacf908c79b3fe2999c153f81fbb5108).
* Implemented liquidity mining of RGT (Rari Governance Token) distributions.
* Rebranded to Rari Yield Pool and Rari Yield Pool Token (RYPT).
* Implemented lending via yVaults.
* Move dApp to `rari-dapp-legacy`. 
* Completely removed account balance limit functions.
* Minor improvements to contracts (e.g., replaced `disableFund` and `enableFund` with `setFundDisabled`).
