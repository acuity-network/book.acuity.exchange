# Price Calculations

For the exchange to operate correctly it is critical that price calculations on different devices give exactly the same results. To ensure that this is the case all currency prices and values are stored as an [arbitrary-precision](https://en.wikipedia.org/wiki/Arbitrary-precision_arithmetic) integer count of the smallest unit. Division is performed using [Integer Division](https://mathworld.wolfram.com/IntegerDivision.html).

The price the seller publishes in the order book is the integer number of small units of buy currency to buy one big unit of sell currency. For example if the seller wanted to sell 1 BTC for 18.9 ETH, the price would be stored as 18,900,000,000,000,000,000. The smallest unit of ETH is WEI and 1 ETH = 10^18 WEI.

Of course, prices can be rendered in a much more human-readable format.

The buyer decides how much of the sell order they wish to buy. To determine the cost in small buy units from price in small buy units and the sell quantity in small sell units, the following equation is used:

```
sell_value - small units of sell asset being bought
sell_price - small units of buy asset to buy one big unit of sell asset
sell_decimals - decimal places between big and small units of sell asset
buy_value - small units of buy asset required to buy sell_value

buy_value = (sell_value * sell_price) \ (10 ^ sell_decimals)
```
