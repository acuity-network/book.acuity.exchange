# Atomic Swap

Once the buyer has decided to proceed with a trade they can start the process by locking up the funds on the buy chain that they want to use to pay for funds on the sell chain. 

## Buy Lock

The buyer issues a transaction on the buy chain to create a buy lock. On an EVM chain this is handled by a smart contract. On a Substrate chain it is handled by the Acuity Atomic Swap pallet.

The parameters are as follows:

```
token - address of the token contract (if ERC20 token)
value - quantity of buy asset to be locked up to buy the sell asset
recipient - the address of the seller on the buy chain
hashed_secret - keccak256(secret)
timeout - how long the lock will last before the buyer can retrieve the value
sell_asset_id - the asset_id of the asset identified on the order book
sell_price - the price of the asset listed on the order book
```

`buy_value` must be determined exactly using `sell_price` as described in the Price Calculations section.

`recipient` is determined by querying connected accounts on the Acuity chain to get the address of the seller on the buy chain.

The buyer must generate a 32 byte random number and keep it secret until the swap is complete. `hashed_secret` is calculated by taking the keccak256 hash of the secret.

`timeout` should be far enough in the future so that half of the time until the timeout expires will be sufficient for the buyer to submit a transaction to unlock the sell lock. If the buy process is being handled manually the timeout will need to be much longer than if it is being handled by a bot. For EVM chains `timeout` should be specified in seconds, for Substrate chains it should be specified in milliseconds.

## Sell Lock

The sell bot will detect that a buy lock has been created with the seller as the recipient. It needs to determine that the buy lock is valid.

First the following values need to be calculated:

* `sell_value`
* `sell_timeout`
* `buy_asset_id`
* `buy_lock_id - keccak256(abi.encode(buyer, seller, hashedSecret, buy_timeout))`

The following conditions must be met:

* `sell_asset_id` must be in the seller's order book
* `sell_price` must be the current price or higher in the seller's order book
* `sell_value` must be less than or equal to the value for sale in the order book
* `timeout` must be sufficiently far in the future
* the buyer's address on the buy chain or sell chain must not be in the seller's blacklist

If they are not met, the seller can call the reject_lock() method on the buy chain with the rejection reason?

If the conditions *are* met the seller should create a lock on the sell chain with the following parameters:

```
token - address of the token contract (if ERC20 token)
value - quantity of sell asset to be locked up vwwto buy the sell asset
recipient - the address of the buyer on the sell chain
hashed_secret - same as the buy lock
timeout - calculated above
buy_asset_id - calculated above
buy_lock_id - calculated above
```

## Buyer Unlocks Sell Lock

The buyer's software will detect the sell lock event. It needs to ensure that all the event parameters are correct.

The sell lock should be approximately 50% as long as the buy lock.

The buyer publishes a transaction to unlock the sell lock and obtain the funds they are buying. This transaction includes the unhashed secret.

## Seller Unlocks Buy Lock

Now that the buyer has revealed the secret the seller now has to unlock the buy lock to retrieve the funds.
