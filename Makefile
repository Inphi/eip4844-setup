GETH=/home/inphi/src/go-ethereum/build/bin/geth
GETH_DATADIR=/home/inphi/ethereum/taunus

#deploy:
	#forge create DepositContract  --contracts src/DepositContract.sol --out out/DepositContract.sol --keystore ${GETH_DATADIR}/keystore/* --password '' --rpc-url http://localhost:8545

deposit:
	node run_deposits.js

init-geth:
	rm -rf ${GETH_DATADIR}
	./make-genesis.sh
	${GETH} --datadir "~/ethereum/taunus" init ./geth_genesis.json

	touch ${GETH_DATADIR}/password
	# address: a94f5374fce5edbc8e2a8697c15331677e6ebf0b
	${GETH}  --datadir ${GETH_DATADIR} --password ${GETH_DATADIR}/password account import ./sk.json

run-geth:
	#${GETH} --verbosity 6 --http --ws -http.api "engine,eth,net"  --datadir ${GETH_DATADIR} --allow-insecure-unlock --unlock "0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b" --password ${GETH_DATADIR}/password --nodiscover console --authrpc.jwtsecret=0x98ea6e4f216f2fb4b69fff9b3a44842c38686ca685f3f55dc48c5d3fb1107be4
	${GETH} --http --ws -http.api "web3,debug,engine,eth,net"  --datadir ${GETH_DATADIR} --allow-insecure-unlock --unlock "0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b" --password ${GETH_DATADIR}/password --nodiscover console --authrpc.jwtsecret=0x98ea6e4f216f2fb4b69fff9b3a44842c38686ca685f3f55dc48c5d3fb1107be4 --mine
