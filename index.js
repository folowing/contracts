const abi = require('./abi.json')
const chains = require('./chains')

for (let chain in chains) {
  module.exports[chain] = {}
  for (let contract in abi) {
    module.exports[chain][contract] = {
      address: chains[chain][contract],
      abi: abi[contract]
    }
  }
}
