# Rari Yield Pool: Deployed Smart Contracts

As follows are all deployments of our smart contracts on the Ethereum mainnet. See [`API.md`](API.md) for reference on these contracts' public methods and [`USAGE.md`](USAGE.md) for instructions on how to use them.

## Latest Versions

### `RariFundController`

`RariFundController` holds supplied funds and is used by the rebalancer to deposit and withdraw from pools and make exchanges.

**v1.0.0**: (to be deployed)

### `RariFundManager`

`RariFundManager` is the Rari Yield Pool's main contract: it handles deposits, withdrawals, USD balances, interest, fees, etc.

**v1.0.0**: (to be deployed)

### `RariFundToken`

The Rari Yield Pool Token (RYPT) is an ERC20 token used to internally account for the ownership of funds supplied to the Rari Yield Pool.

**v1.0.0**: (to be deployed)

### `RariFundPriceConsumer`

`RariFundPriceConsumer` retrieves stablecoin prices from Chainlink's public price feeds (used by `RariFundManager` and `RariFundController`).

**v1.0.0**: (to be deployed)

### `RariFundProxy`

`RariFundProxy` includes wrapper functions built on top of `RariFundManager`: exchange and deposit, withdraw and exchange, deposit without paying gas via the Gas Station Network (GSN).

**v1.0.0**: (to be deployed)
