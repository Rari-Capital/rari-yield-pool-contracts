# Rari Yield Pool: Smart Contracts

Welcome to `rari-yield-pool-contracts`, the central repository for the Solidity source code behind the Rari Yield Pool's Ethereum-based smart contracts (with automated tests and documentation).

## How it works

The Rari Yield Pool is a decentralized and fully-audited stablecoin lending aggregator optimized for yield based on the Ethereum blockchain. A high-level overview of how the Rari Yield Pool works is available in [`CONCEPT.md`](CONCEPT.md). This information is also [available online](https://rari.capital/current.html). Find out more about Rari Capital at [rari.capital](https://rari.capital).

## Contract usage

Documentation on common usage of the contracts is available in [`USAGE.md`](USAGE.md). Detailed API documentation for our smart contracts' public methods is available in [`API.md`](API.md). Smart contract ABIs are available in the `abi` properties of the JSON files in the `build` folder. For easy implementation, see the [Rari JavaScript SDK](https://github.com/Rari-Capital/rari-sdk).

## Installation (for development and deployment)

We, as well as others, had success using Truffle on Node.js `v12.18.2` with the latest version of NPM.

To install the latest version of Truffle: `npm install -g truffle`

*Though the latest version of Truffle should work, to compile, deploy, and test our contracts, we used Truffle `v5.1.45` (which should use `solc` version `0.5.17+commit.d19bba13.Emscripten.clang` and Web3.js `v1.2.1`).*

To install all our dependencies: `npm install`

## Compiling the contracts

`npm run compile`

## Testing the contracts

In `.env`, set `DEVELOPMENT_ADDRESS=0x45D54B22582c79c8Fb8f4c4F2663ef54944f397a` to test deployment and also set `DEVELOPMENT_ADDRESS_SECONDARY=0x1Eeb75CFad36EDb6C996f7809f30952B0CA0B5B9` to run automated tests.

If you are upgrading from `v1.2.0` or `v1.2.1`, set `UPGRADE_FROM_LAST_VERSION=1` to enable upgrading and configure the following:

    UPGRADE_FUND_OLD_CONTROLLER_ADDRESS=0x6afE6C37bF75f80D512b9D89C19EC0B346b09a8d
    UPGRADE_FUND_MANAGER_ADDRESS=0x59FA438cD0731EBF5F4cDCaf72D4960EFd13FCe6
    UPGRADE_FUND_OWNER_ADDRESS=0x10dB6Bce3F2AE1589ec91A872213DAE59697967a

Then, copy the OpenZeppelin artifacts for the official deployed `v1.2.0`/`v1.2.1` contracts from `.openzeppelin/mainnet.json` to `.openzeppelin/unknown-1337.json`. If you decide to disable upgrading by setting restoring `UPGRADE_FROM_LAST_VERSION=0`, make sure to delete `.openzeppelin/unknown-1337.json`.

To test the contracts, first fork the Ethereum mainnet. Begin by configuring `DEVELOPMENT_WEB3_PROVIDER_URL_TO_BE_FORKED` in `.env` (set to any mainnet Web3 HTTP provider JSON-RPC URL; we use a local `geth` instance, specifically a light client started with `geth --syncmode light --rpc --rpcapi eth,web3,debug,net`; Infura works too, but beware of latency and rate limiting). To start the fork, run `npm run ganache`. *If you would like to change the port, make sure to configure `scripts/ganache.js`, `scripts/test.sh`, and the `development` network in `truffle-config.js`.* Note that you will likely have to regularly restart your fork, especially when forking from a node without archive data or when using live 0x API responses to make currency exchanges.

To deploy the contracts to your private mainnet fork: `truffle migrate --network development --skip-dry-run --reset`

To run automated tests on the contracts on your private mainnet fork, run `npm test` (which runs `npm run ganache` in the background for you). If you are upgrading from `v1.2.0` or `v1.2.1`, you must also set the following variables in `.env`:

    UPGRADE_FUND_TOKEN_ADDRESS=0x3baa6B7Af0D72006d3ea770ca29100Eb848559ae
    UPGRADE_FUND_PRICE_CONSUMER_ADDRESS=0x00815e0e9d118769542ce24be95f8e21c60e5561
    UPGRADE_FUND_PROXY_ADDRESS=0x35DDEFa2a30474E64314aAA7370abE14c042C6e8

If you'd like to test gasless deposits via `RariFundProxy.deposit` via the Gas Station Network:

* Download `https://github.com/OpenZeppelin/openzeppelin-gsn-provider/blob/master/bin/gsn-relay` to `bin/gsn-relay` and set permissions with `chmod +x bin/gsn-relay`.
* Making sure `npx` is installed, run `npm dev-gsn`.
* Fund `RariFundProxy` using `npx @openzeppelin/gsn-helpers fund-recipient --recipient $RARI_FUND_PROXY_ADDRESS -n http://localhost:8546 -f $FROM_ADDRESS` or [this tool](https://www.opengsn.org/recipients) (or manually send ETH to `RelayHub(0xD216153c06E857cD7f72665E0aF1d7D82172F494).depositFor(address target)`).
* Run `rari-gsn-signer` with `pm2 start ecosystem.config.js` after configuring `ecosystem.config.js`.

## Live deployment

In `.env`, configure `LIVE_DEPLOYER_ADDRESS`, `LIVE_DEPLOYER_PRIVATE_KEY`, `LIVE_WEB3_PROVIDER_URL`, `LIVE_GAS_PRICE` (ideally, use the "fast" price listed by [ETH Gas Station](https://www.ethgasstation.info/)), `LIVE_FUND_OWNER`, `LIVE_FUND_REBALANCER`, `LIVE_FUND_INTEREST_FEE_MASTER_BENEFICIARY`, `LIVE_FUND_WITHDRAWAL_FEE_MASTER_BENEFICIARY`, and `LIVE_FUND_GSN_TRUSTED_SIGNER` to deploy to the mainnet.

If you are upgrading from `v1.2.0` or `v1.2.1`, set `UPGRADE_FROM_LAST_VERSION=1` to enable upgrading and configure the following:

    UPGRADE_FUND_OLD_CONTROLLER_ADDRESS=0x6afE6C37bF75f80D512b9D89C19EC0B346b09a8d
    UPGRADE_FUND_MANAGER_ADDRESS=0x59FA438cD0731EBF5F4cDCaf72D4960EFd13FCe6
    UPGRADE_FUND_OWNER_ADDRESS=0x10dB6Bce3F2AE1589ec91A872213DAE59697967a

You must also set `LIVE_UPGRADE_FUND_OWNER_PRIVATE_KEY`.

Then, migrate: `truffle migrate --network live`

If you'd like to provide gasless deposits via `RariFundProxy.deposit` via the Gas Station Network:

* Fund `RariFundProxy` using `npx @openzeppelin/gsn-helpers fund-recipient --recipient $RARI_FUND_PROXY_ADDRESS -n $ETHEREUM_NODE_URL -f $FROM_ADDRESS` or [this tool](https://www.opengsn.org/recipients) (or manually send ETH to `RelayHub(0xD216153c06E857cD7f72665E0aF1d7D82172F494).depositFor(address target)`).
* Run `rari-gsn-signer` with `pm2 start ecosystem.config.js --env production` after configuring `ecosystem.config.js`.

## License

See `LICENSE`.

## Credits

Rari Capital's smart contracts are developed by [David Lucid](https://github.com/davidlucid). Find out more about Rari Capital at [rari.capital](https://rari.capital).
