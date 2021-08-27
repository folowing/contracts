# Truebit Contracts

Truebit contract interfaces and ABI.

## Interfaces in Solidity

Install this package

```
npm install @truverse/contracts
```

Use it in your contract

```solidity
import "@truverse/contracts/Truebit.sol";
```

You can also import individual interfaces

```solidity
import "@truverse/contracts/truebit/TRU.sol";
import "@truverse/contracts/truebit/Purchase.sol";
```

## ABI and adresses in JSON

ABI and addresses

```js
const truebit = require('@truverse/contracts').mainnet

const fs = new web3.eth.Contract(truebit.filesystem.abi, truebit.filesystem.address)
const tru = new web3.eth.Contract(truebit.tru.abi, truebit.tru.address)
```

ABI

```js
const abi = require('@truverse/contracts/abi')

const fs = new web3.eth.Contract(abi.filesystem)
const tru = new web3.eth.Contract(abi.tru)
```

Addresses

```js
const abi = require('@truverse/contracts/abi')
const chain = require('@truverse/contracts/chains/mainnet')

const fs = new web3.eth.Contract(abi.filesystem, chain.filesystem)
const tru = new web3.eth.Contract(abi.tru, chain.tru)
```

## Contents

`Truebit.sol` is a single hand-crafted file that contains the following interfaces

* `Truebit` (incentive layer)
* `FileSystem`
* `TRU`
* `Purchase`

There are also automatically generated interfaces in individual files under `truebit/`

* `Incentive.sol`
* `FileSystem.sol`
* `TRU.sol`
* `Purchase.sol`
* `Interactive.sol`
* `Judge.sol`
* `IPFS.sol`

## Contract names

| `Truebit.sol` | `truebit/X.sol` | `abi.json`  | `truebit-eth`   |
| ------------- | --------------- | ----------- | --------------- |
| Truebit       | Incentive       | incentive   | incentiveLayer  | 
| FileSystem    | FileSystem      | filesystem  | fileSystem      | 
| TRU           | TRU             | tru         | tru             | 
| Purchase      | Purchase        | purchase    | purchase        | 
| n/a           | Interactive     | interactive | interactive     | 
| n/a           | Judge           | judge       | judge           | 
| n/a           | IPFS            | ipfs        | IPFSnodeManager | 

## Chains

| Chain       | ID    | Aliases                |
| ----------- | ----- | ---------------------- |
| Ethereum    | 1     | `1`, `mainnet`, `main` |
| Goerli      | 5     | `5`, `goerli`, `görli` |

## Generation

Install `abi-to-sol` which is already in `devDependencies`

```
npm install
```

Generate Solidity interface files

```
VERSION="=0.5.0"
LICENSE="Apache-2.0"
jq .incentive   abi.json | npx abi-to-sol -V $VERSION -L $LICENSE Incentive   > truebit/Incentive.sol
jq .tru         abi.json | npx abi-to-sol -V $VERSION -L $LICENSE TRU         > truebit/TRU.sol
jq .purchase    abi.json | npx abi-to-sol -V $VERSION -L $LICENSE Purchase    > truebit/Purchase.sol
jq .filesystem  abi.json | npx abi-to-sol -V $VERSION -L $LICENSE FileSystem  > truebit/FileSystem.sol
jq .interactive abi.json | npx abi-to-sol -V $VERSION -L $LICENSE Interactive > truebit/Interactive.sol
jq .judge       abi.json | npx abi-to-sol -V $VERSION -L $LICENSE Judge       > truebit/Judge.sol
jq .ipfs        abi.json | npx abi-to-sol -V $VERSION -L $LICENSE IPFS        > truebit/IPFS.sol

# some bug in abi-to-sol that does not like >=0.5.0
sed -i '' -e 's/=0.5.0/>=0.5.0/g' $(find ./truebit -type f -name '*.sol')
```

## License

[Truebit](https://github.com/TruebitProtocol/truebit-eth) is not open source but their [previous codebase](https://github.com/truebitfoundation/truebit-os/) was released under [Apache 2.0](https://github.com/TrueBitFoundation/truebit-os/blob/master/LICENSE).

The generated interface files in this repository are licensed under [Apache 2.0](https://www.apache.org/licenses/LICENSE-2.0).
