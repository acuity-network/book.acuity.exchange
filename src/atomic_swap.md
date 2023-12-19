# Atomic Swap

Once the buyer has decided to proceed with a trade they can start the process by locking up the funds on the buy chain that they want to use to pay for funds on the sell chain. 

## Buy Lock

The buyer issues a transaction on the buy chain to create a buy lock. On an EVM chain this is handled by a smart contract. On a Substrate chain it is handled by the Acuity Atomic Swap pallet.

The parameters are as follows:

```
token - address of the token contract (if ERC20 token)
buy_value - quantity of buy asset to be locked up to buy the sell asset
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
