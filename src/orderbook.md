# Order Book

There are two participants in a trade on the Acuity DEX - the buyer and the seller. The seller is typically a bot and publishes sell orders via the Acuity DEX blockchain.

The order book will be maintained offchain by an indexer than can be run locally. This ensures transactions fees are as low as possible.

For a given trading pair, the Acuity Bot (written in Rust) first constructs the current state of the order book.

* It uses the Acuity DEX Indexer to get all active orders.
* It checks the balance on the sell chain of the sell address of each order. Orders with insufficient balance are marked as such.
* The orders are ordered by sell price.

The bot then watches for order changes from the Acuity chain and locks on the trading chains to keep the order book up to date.

The bot can be queried at any time to obtain the full order book. It can be subscribed to for updates.
