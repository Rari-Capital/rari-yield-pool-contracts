# Rari Yield Pool: Deployed Smart Contracts

As follows are all deployments of our smart contracts on the Ethereum mainnet. See [`API.md`](API.md) for reference on these contracts' public methods and [`USAGE.md`](USAGE.md) for instructions on how to use them.

## Latest Versions

### `RariFundController`

`RariFundController` holds supplied funds and is used by the rebalancer to deposit and withdraw from pools and make exchanges.

**v1.3.0**: `0x9245efB59f6491Ed1652c2DD8a4880cBFADc3ffA`

### `RariFundManager`

`RariFundManager` is the Rari Yield Pool's main contract: it handles deposits, withdrawals, USD balances, interest, fees, etc.

**v1.1.0**: `0x59FA438cD0731EBF5F4cDCaf72D4960EFd13FCe6`

Logic implementation contract: `0x26a7ac3e22e56aa1d23ba3702e835104d77db94e`

### `RariFundToken`

The Rari Yield Pool Token (RYPT) is an ERC20 token used to internally account for the ownership of funds supplied to the Rari Yield Pool.

**v1.0.0**: `0x3baa6B7Af0D72006d3ea770ca29100Eb848559ae`

Logic implementation contract: `0x17728F7dD30b6e87D597a54B3a6863CF4e96Aa4D`

### `RariFundPriceConsumer`

`RariFundPriceConsumer` retrieves stablecoin prices from Chainlink's public price feeds (used by `RariFundManager` and `RariFundController`).

**v1.0.0**: `0x00815e0e9d118769542ce24be95f8e21c60e5561`

Logic implementation contract: `0xD7d2d97C61AfB3045039584Dc654B926694083C5`

### `RariFundProxy`

`RariFundProxy` includes wrapper functions built on top of `RariFundManager`: exchange and deposit, withdraw and exchange, deposit without paying gas via the Gas Station Network (GSN).

**v1.2.0**: `0x35DDEFa2a30474E64314aAA7370abE14c042C6e8`

## Older Versions

### RariFundController

* **v1.0.0**: `0x6afE6C37bF75f80D512b9D89C19EC0B346b09a8d`

### `RariFundManager`

* **v1.0.0**: `0x59FA438cD0731EBF5F4cDCaf72D4960EFd13FCe6`

### `RariFundProxy`

* **v1.1.0**: `0x626d6979F3607d13051594d8B27a0A64E413bC11`
* **v1.0.0**: `0x6dd8e1Df9F366e6494c2601e515813e0f9219A88`
