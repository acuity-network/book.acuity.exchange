# Atomic Swap

Once the buyer has decided to proceed with a trade they need to lock up the funds on the buy chain that they want to use to pay for funds on the sell chain. 

## Buy Lock

The buyer issues a transaction on the buy chain to create a buy lock. On an EVM chain this is handled by a smart contract. On a Substrate chain it is handled by the Acuity Atomic Swap pallet.

The parameters are as follows:

```
buy_value - quantity of buy asset to be locked up to buy the sell asset
recipient - the address of the seller on the buy chain
hashed_secret - 
timeout - 
sell_asset_id - 
sell_price - 
```
