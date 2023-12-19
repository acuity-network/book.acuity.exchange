# Asset Identification

During the trading process it is essential that traders can identify which assets are being bought and sold. Acuity has a 32 byte asset_id that can identify any asset on any chain.

The first 2 bytes identify the chain. The layout of the remaining bytes depends on the chain.

```
1 - Substrate
2 - EVM
3 - Cosmos
4 - Bitcoin
```

Here is the layout for EVM chains:

```
2 bytes chain type 0x0002 for EVM chain
6 bytes chain_id - see https://chainlist.org/
2 bytes asset_type - 0x0000 for base, 0x0001 for ERC20
2 bytes adapter_id - which atomic swap smart contract to use
20 bytes token address - for ERC20 tokens the address is stored here
```

For each chain_id / asset_type / adapter_id the DEX software knows the correct smart contract to use
