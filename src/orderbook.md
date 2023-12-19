# Order Book

There are two participants in a trade on the Acuity DEX - the buyer and the seller.

The seller is typically a bot and publishes sell orders via the Acuity blockchain. Currently, the order book is stored in chain state.

For the order book for a given pair to be presented to a potential buyer, it first needs to be retrieved from chain state. Then the address of each seller on the sell chain needs to be examined to determine if the balance is sufficient.

When is the order book updated after a trade?

## Offchain Order Book

In a later version of the DEX, orders will still be submitted to the Acuity blockchain, but they will not be stored in state. Rather the order book will be maintained offchain by an indexer than can be run locally. This will reduce the transactions fees to maintain sell orders.

For a given trading pair, the Acuity Order Book Bot (written in Rust) first constructs the current state of the order book.

* It uses the Acuity DEX Indexer to get all active orders.
* It checks the balance on the sell chain of the sell address of each order. Orders with insufficient balance are marked as such.
* The orders are ordered by sell price.

The bot then watches for order changes from the Acuity chain and locks on the trading chains to keep the order book up to date.

The bot can be queried at any time to obtain the full order book. It can be subscribed to for updates.

The order book bot will typically be used by: the web trading app, the desktop trading app, and the selling bot.
