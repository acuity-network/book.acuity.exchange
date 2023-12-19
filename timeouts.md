# Acuity DEX Timeouts

seller publishes sell order on Acuity
- pair
- price
- value

aggregator gets order book, checks that seller has funds to sell

Buyer makes buy lock on buy chain including hashed secret, seller, sellAssetId, sellPrice and value.

Seller verifies buy lock and creates corresponding sell lock with hashed secret.

Buyer verifies sell lock and unlocks it with the secret.

Seller obtains the secret and unlocks the buy lock.

## Cross-chain State Machine

Buy lock   | Sell lock   | Status
----------------------------------
Not locked | Not locked  | Buyer can lock buy lock
Locked     | Not locked  | Seller can lock sell lock, if there is enough time
Locked     | Locked      | Buyer can unlock sell lock and reveal secret
Locked     | Unlocked    | Seller can unlock buy lock with secret
Unlocked   | Unlocked    | Trade succeeded

Timed out  | Not locked  | Buyer can retrieve buy lock, trade failed - no funds lost

Locked     | Timed out   | Seller can retrieve sell lock, buyer must wait
Timed out  | Locked      | Sell timeout was wrong - seller must wait
Timed out  | Timed out   | Buyer and seller can retrieve locks, trade failed - no funds lost

Unlocked   | Timed out   | The buyer revealed the secret after the sell lock had timed out, enabling the seller to take the funds from both locks

```
Buy lock------------------------
|
|      Sell lock------------------------
|                                      |
| ----------Buyer can unlock sell lock |
| |                                    |
| | Seller can unlock buy lock         |
| |                                    |
| |    Sell lock timeout----------------
| |
| | This gap must be big enough for seller to unlock buy lock
| |
| | Seller can retrieve sell lock, if not already unlocked by buyer
| |
Buy lock timeout----------------

Buyer can retrieve buy lock, if not already unlocked by seller
```

The buy lock must give enough time for the seller to create a lock that allows both traders enough time to unlock.
The sell lock must give enough time for the buyer to unlock, and for the seller to unlock between the timeouts.

## Timeout negotiation
Who decides the lock timeout? Buyer decides buy lock timeout. Then seller decides sell lock timeout.

Seller is typically a bot.


If buy lock is too long, seller will reject. Seller should specify max timeout acceptable.

Seller should create lock that is half as long as the buy lock, if that is not too short or too long.

Seller should create a lock so that the time between the timeouts is half the total time of the buy lock.


unlocking must ensure the tx will confirm before timeout


should decline exist?

what if the buyer has no funds to unlock the sell lock??
enable third party to send the tx?
pay for tx on another chain

Buyer unlocks buy lock (publishing the secret) - someone else will unlock the sell lock, receving some funds
Buyer unlocks buy lock (publishing the secret) - seller will unlock the sell lock. Sell timeout is extremely long. If seller does not unlock it the buyer will need to find base funds or someone else to send the tx. 


Trading Bot

Controller Bot
