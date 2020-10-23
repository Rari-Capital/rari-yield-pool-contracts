# Rari Yield Pool: How it Works

This document explains how the Rari Yield Pool works under the hood. This content is also available [on our website](https://rari.capital/current.html).

## Generating Yield

Currently, the Rari Yield Pool generates yield by depositing a combination of:

* DAI and USDC to the lending protocol [dYdX](https://dydx.exchange/)
* DAI, USDC, and USDT to the lending protocol [Compound](https://compound.finance/)
* DAI, USDC, USDT, TUSD, BUSD, and sUSD to the lending protocol [Aave](https://aave.com/)
* mUSD to the savings protocol from [mStable](https://mstable.org/)
* DAI to the yVault protocol from [yearn.finance](https://yearn.finance/vaults)

Rari optimizes yield not only by allocating assets to the pools with the highest interest rates, but also by exchanging assets to the stablecoins with the highest interest rates via a combination of:

* the [0x](https://0x.org/) exchange
* swapping via mUSD from [mStable](https://mstable.org)

In the near future, we will be generating yield from more currencies across more lending protocols, among other strategies.

## RYPT (Rari Yield Pool Token)

Each user's share of the Rari Yield Pool is represented by their RYPT (Rari Yield Pool Token) balance. When you deposit funds to the Yield Pool, an equivalent amount of RYPT is minted to your account. When you withdraw funds from the Yield Pool, the equivalent amount of RYPT is burned from your account. As soon as you deposit, you start earning yield. Essentially, Rari Yield Pool holdings and yield are split up across RYPT holders proportionally to their balances.

## Deposits

Only certain stablecoins are accepted for direct deposits (direct meaning without exchange to an accepted currency). To deposit another currency, you must exchange your funds before depositing. Fortunately, Rari can exchange and deposit your funds in the same transaction via [0x](https://0x.org/) and/or [mStable](https://mstable.org) (please be aware that exchanges via 0x are subject to slippage due to price spread as well as an ETH protocol fee, and exchanges via mStable are subject to a small denominational percentage fee, but can avoid slippage and even get you a bonus).

See [`USAGE.md`](USAGE.md) for more information on how to deposit via the smart contracts and [`API.md`](API.md) for a detailed reference on the smart contract methods involved. See the Rari SDK for easy implementation and the web client for easy usage.

## Withdrawals

Only the stablecoins currently held by the Rari Yield Pool are available for direct withdrawals. To withdraw another currency, you must exchange your funds after withdrawing. Fortunately, Rari can withdraw and exchange your funds in the same transaction via [0x](https://0x.org/) and/or [mStable](https://mstable.org) (please be aware that exchanges via 0x are subject to slippage due to price spread as well as an ETH protocol fee, and exchanges via mStable are subject to a small denominational percentage fee, but can avoid slippage and even get you a bonus).

See [`USAGE.md`](USAGE.md) for more information on how to withdraw via the smart contracts and [`API.md`](API.md) for a detailed reference on the smart contract methods involved. See the Rari SDK for easy implementation and the web client for easy usage.

## Structure

We have 4 user-facing **smart contracts** in total (see [`DEPLOYED.md`](DEPLOYED.md) for deployed addresses):

* `RariFundManager` is the Rari Yield Pool's main contract, handling deposits, withdrawals, USD balances, interest, fees, etc.
* `RariFundController` holds supplied funds and is used by the rebalancer to deposit and withdraw from pools and make exchanges.
* `RariFundToken` is the contract behind the Rari Yield Pool Token (RYPT), an ERC20 token used to internally account for the ownership of funds supplied to the Rari Yield Pool.
* `RariFundPriceConsumer` retrieves stablecoin prices from Chainlink's public price feeds (used by `RariFundManager` and `RariFundController`).
* `RariFundProxy` includes wrapper functions built on top of `RariFundManager`: exchange and deposit, withdraw and exchange, and deposit without paying gas via the Gas Station Network (GSN).

A centralized (but soon to be decentralized) **rebalancer** controls which pools hold which currencies at any given time but only has permission to move funds between pools and exchange currencies, not withdraw funds elsewhere.

## Security

Rari's Ethereum-based smart contracts are written in Solidity and reviewed by multiple partners for security. Rari does not have control over your funds: instead, the Ethereum blockchain executes all secure code across its entire decentralized network (making it very difficult and extremely costly to rewrite history), and your funds are only withdrawable by you.

While the centralized (but soon to be decentralized) rebalancer does have control over which pools hold which currencies at any given time but only has permission to move funds between pools and exchange currencies, not withdraw funds elsewhere. Losses due to exchange slippage in a 24-hour period are limited proportionally to the total supply for security since 0x orders can come from anywhere. However, the rebalancer can approve any amount of funds to the pools and exchanges integrated.

Please note that at the moment, smart contract upgrades are approved via a 3-of-5 multisig federation controlled by Rari's co-founders and partners. However, upgrades will become decentralized in the future via a governance protocol based on a new token.

Please note that using our web client online at [app.rari.capital](https://app.rari.capital) is not nearly as trustworthy as downloading, verifying, and using it offline. Lastly, the rebalancer is centralized, but it can only rebalance funds to different currencies and pools. In the near future, we will be implementing a smart-contract-based (and therefore decentralized) slippage limit.

## Risk

We have covered security above, but see [our website](https://rari.capital/risks.html) for more information on the risks associated with supplying funds to Rari.

## Performance Fee

A 9.5% performance fee is deducted from all interest earned by RYPT holders. This fee is liable to change in the future (but fees on past interest cannot be changed).

## COMP

All [COMP (Compound's governance token)](https://compound.finance/governance/comp) earned by the fund is liquidated into additional interest for RYPT holders approximately every 3 days.
