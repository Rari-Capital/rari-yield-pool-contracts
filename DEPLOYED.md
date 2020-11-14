# Rari Yield Pool: Deployed Smart Contracts

As follows are all deployments of our smart contracts on the Ethereum mainnet. See [`API.md`](API.md) for reference on these contracts' public methods and [`USAGE.md`](USAGE.md) for instructions on how to use them.

## Latest Versions

### `RariFundController`

`RariFundController` holds supplied funds and is used by the rebalancer to deposit and withdraw from pools and make exchanges.

**v1.0.0**: `0x6afE6C37bF75f80D512b9D89C19EC0B346b09a8d`

### `RariFundManager`

`RariFundManager` is the Rari Yield Pool's main contract: it handles deposits, withdrawals, USD balances, interest, fees, etc.

**v1.1.0**: `0x59FA438cD0731EBF5F4cDCaf72D4960EFd13FCe6`

### `RariFundToken`

The Rari Yield Pool Token (RYPT) is an ERC20 token used to internally account for the ownership of funds supplied to the Rari Yield Pool.

**v1.0.0**: `0x3baa6B7Af0D72006d3ea770ca29100Eb848559ae`

### `RariFundPriceConsumer`

`RariFundPriceConsumer` retrieves stablecoin prices from Chainlink's public price feeds (used by `RariFundManager` and `RariFundController`).

**v1.0.0**: `0x00815e0e9d118769542ce24be95f8e21c60e5561`

### `RariFundProxy`

`RariFundProxy` includes wrapper functions built on top of `RariFundManager`: exchange and deposit, withdraw and exchange, deposit without paying gas via the Gas Station Network (GSN).

**v1.1.0**: (to be deployed)

## Older Versions

### `RariFundManager`

* **v1.0.0**: `0x59FA438cD0731EBF5F4cDCaf72D4960EFd13FCe6`

### `RariFundProxy`

* **v1.0.0**: `0x6dd8e1Df9F366e6494c2601e515813e0f9219A88`
