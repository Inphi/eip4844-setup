#!/usr/bin/env bash

function get_deployed_bytecode() {
    echo $(jq -r .deployedBytecode.object $1)
}

DEPOSIT_CONTRACT_ADDRESS=0x8A04d14125D0FDCDc742F4A05C051De07232EDa4
DEPOSIT_CONTRACT_BYTECODE=$(get_deployed_bytecode out/DepositContract.sol/DepositContract.json)

jq ". | .alloc.\"$DEPOSIT_CONTRACT_ADDRESS\".code = \"$DEPOSIT_CONTRACT_BYTECODE\"" < ./base_genesis2.json | \
    jq ". | .alloc.\"$DEPOSIT_CONTRACT_ADDRESS\".balance = \"0x0\"" > ./geth_genesis.json
