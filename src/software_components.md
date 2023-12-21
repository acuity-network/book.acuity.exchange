# Software Components

## Acuity DEX Frontend

Frontend application built with Rust, [Sycamore](https://sycamore-rs.netlify.app/) & Tailwind.

Builds for Web, Mobile ([PWA](https://en.wikipedia.org/wiki/Progressive_web_app)), Desktop ([Tauri](https://tauri.app/)).

2 modes of operation:

* Can perform buys by issuing transactions via a wallet such as MetaMask.
* Using Trader Bot as the automatic hot wallet.

Status: Needs to be rebuilt from [previous app](https://github.com/acuity-social/acuity-dex-app) (written in Vue 3 & TypeScript).

## Acuity Indexer

Both the frontend and the trader bot need to be able to query and subscribe to events from the following on the Acuity blockchain:

* Connected Accounts
* Trusted Accounts
* Order Book
* Atomic Swap

This component uses [Hybrid Indexer](https://github.com/hybrid-explorer/hybrid-indexer) to enable indexing of and subscribing to events on the Acuity blockchain.

## Acuity DEX EVM Indexer

This indexer can index the Acuity DEX smart contracts on any EVM chain.

## Acuity Blockchain

Substrate-based chain to manage the DEX.

* Order publishing
* Cross-chain account connection
* Trusted accounts

Already written - needs updated to latest version of Substrate.

[Repository](https://github.com/acuity-social/acuity-substrate)

### Order Book Pallet

Already written - needs updated to latest version of Substrate.

[Repository](https://github.com/acuity-social/acuity-orderbook-pallet)

## Trader Bot

Has the keys to the hot wallet.

Automatically issues the transactions necessary to perform an atomic swap as either seller or buyer. It can also be instructed to set and remove sell orders.

Not yet implemented.

## Controller Bot

A controller bot can be written in any language to tell the trader bot what the sell orders should be.

## EVM Atomic Swap Smart Contracts

Most EVM chains can have their base coin and ERC20 tokens traded on Acuity by deploying these contracts.

[Repository](https://github.com/acuity-social/acuity-atomic-swap-solidity)

## Substrate Atomic Swap Pallet

Substrate chains without smart contract functionality will need to add this pallet to their runtime via the on-chain governance mechanism before the base coin can be traded on Acuity.

Currently, tokens managed by the [Assets Pallet](https://marketplace.substrate.io/pallets/pallet-assets/) are not supported.

[Repository](https://github.com/acuity-social/acuity-atomic-swap-pallet)
