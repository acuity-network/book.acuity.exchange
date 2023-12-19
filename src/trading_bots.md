# Trading Bots

In order for buyers to be able to quickly buy on the DEX, it is vital that sellers are running automated trading bots to provide liquidity.

Acuity trading bots actually have two components:

## Acuity Automated Trader

Written in Rust.

This program performs trades on the Acuity DEX as instructed by the controller via WebSockets.

It maintains a hot wallet of all the cryptocurrencies that it is trading.

Watches for Acuity atomic swap events on trading chains.

Maintains sell orders on the Acuity chain as instructed by the controller.

Executes sell orders.

Should the orderbook be maintained in chain state, or constructed by the indexer?

## Controller

Can be written in any language. Communicates with the automated trader via WS.

Instructs the automated trader what should be in the orderbook.
