# DEX Dapp

Acuity DEX user interface built with Rust, [Sycamore](https://sycamore-rs.netlify.app/) & Tailwind. Builds for Web, Mobile ([PWA](https://en.wikipedia.org/wiki/Progressive_web_app)), Desktop ([Tauri](https://tauri.app/)).

Supports trading on both the intra-chain DEX and the cross-chain atomic swap DEX.

## Wallets

Transactions are issued via third-party wallets such as MetaMask (EVM chains) and [Polkadot{.js}](https://polkadot.js.org/extension/) (Substrate chains such as Acuity DEX).

Additionally, when performing cross-chain trades with the desktop build, the dapp can use the Acuity DEX Bot as a hot wallet that will automatically issue the correct transactions to perform atomic swaps.

## Social Network

The dapp uses the Acuity DEX chain and Acuity DEX contracts on EVM chains to enable cross-chain account linking and building of the trusted accounts social graph.

Status: Needs to be rebuilt from [previous app](https://github.com/acuity-social/acuity-dex-app) (written in Vue 3 & TypeScript).
