# Intra-chain Trading Contracts

While the main purpose of the Acuity DEX is to facilitate cross-chain atomic swap trades, it will also support intra-chain trading. This will be the first component to be deployed and will support any [EVM](https://ethereum.org/developers/docs/evm) chain.

Intra-chain trading is dominated by [constant function market maker](https://en.wikipedia.org/wiki/Constant_function_market_maker) exchanges such as [Uniswap](https://uniswap.org/). These exchanges are unable to determine asset market value in isolation. Rather, they rely on arbitrage with order book exchanges (typically centralized) for the trading price to be correct.

The purpose of Acuity intra-chain trading is to provide an on-chain order book exchange so that asset market value can be determined fully on-chain.

The under-development ERC20/ERC20 contract is [here](https://github.com/acuity-social/acuity-dex-intrachain-solidity/blob/master/src/AcuityIntrachainERC20.sol).

## Architecture

### Sell Orders

Each order is composed of a key and a value. The key is 32 bytes (EVM word size) containing the account that is selling and the price they are selling at.

```
 32 bytes
╭─────────────────────┬─────────────╮
│ seller address      │ sell price  │
│ 20 bytes            │ 12 bytes    │
╰─────────────────────┴─────────────╯
```

The meaning of the 96-bit sell price integer is explained in the [Price Calculations](../../price_calculations.md) section.

Each order key is mapped to a 256-bit integer that represents how much of the sell asset is for sale in the order. This mapping is the value in a double mapping of sell token and buy token.

```
sell_token => (buy_token => (order_key => value))
```

The order keys are also stored in an ordered linked list for each token pair. Orders are ordered by sell price from lowest to highest.

```
sell_token => (buy_token => (order_key => next_order_key))
```

The lowest priced sell order is linked to by an order key of 0.

When sell creates a sell order the token is transferred to the smart contract and the linked list is traversed to find the correct place to insert the order.

When amending an order it is simply a matter of increasing or decreasing the mapped value. If the value is reduced to 0 the order is removed from the linked list completely.

### Buying

To buy from an order book, the buyer specifies the sell_token, buy_token and buy_value. The order book for the pair is traversed from the beginning.

For each order:
* Calculate matched_sell_value - how much of sell_asset the buyer would get if they sold buy_value at the order's sell_price.
* If the order value is greater than matched_sell_value, a partial buy is performed. The order is reduced by matched_sell_value and buy_value is transferred directly from buyer to seller. total_sell_value is incremented by matched_sell_value. Order traversing stops.
* Otherwise, a full buy is performed. The order is deleted and the buy value to purchase the whole order is transferred from buyer to seller. total_sell_value is incremented by the value of the order. Now the process continues with the next order.

total_sell_value is transferred from the DEX contract to the buyer. 
