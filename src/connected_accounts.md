# Connected Accounts

In order to trade on the Acuity DEX traders must link their addresses on trading chains with their Acuity address.

The link is 2-way. This proves that the link is correct and enables lookups to occur in both directions.

* Transactions on the Acuity chain can register the sender's addresses on other chains. This occurs in the [order book pallet](https://github.com/acuity-social/acuity-orderbook-pallet/blob/c37b3de53eae78de87b169a12a44bd953df444b7/src/lib.rs#L178).
* Transactions on the EVM trading chains can register the sender's Acuity address in the [AcuityAccount](https://github.com/acuity-social/acuity-atomic-swap-solidity/blob/main/src/AcuityAccount.sol) smart contract.

When the buyer creates a buy order they need to know the seller's address on the buy chain. They look this up on the Acuity chain.

For the seller to create the sell lock they need to use the buyer's address from the buy lock to look up the buyer's address on the sell chain.
