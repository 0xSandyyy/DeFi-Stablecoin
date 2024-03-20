# DeFi Stablecoin
1.  Anchored or pegged to USD 
    1. Chinlink Price Feed
    2. Set a function to exhange the dollar equivalent.

2. Stability Mechanism(Minting): Algorithmic (Decentralized)
    1. People can only mint the stablecoin with enough collateral(coded)

3. Collateral: Exogenous(Crypto)
    1. ETH -> ERC20 or wrapped eth(WETH)
    2. BTC -> ERC20 or wrapped brc(WBTC)

# Build the project
```shell

forge build
```

# Tests
```shell
# To run tests

forge test
```

# For Anvil Deployment
There is a deployment script set up in script/DeployDSC.s.sol

```shell

# First initialize anvil

1. $ Anvil
```


2.
```
Set up .env with ANVIL_RPC_URL, PRIVATE_KEY_ANVIL and DEFAULT_ANVIL_KEY

```

3. 
```shell
$ source .env

```

4. 
```shell
$ forge script script/DeployDSC.s.sol --rpc-url $ANVIL_RPC_URL --private-key $PRIVATE_KEY_ANVIL --broadcast

```