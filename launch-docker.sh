#!/bin/bash

DATADIR=$HOME/docker-data/bitcoin
RPCUSER=bitcoin
RPCPASSWORD=bitcoinrpc

mkdir -p $DATADIR/blocks
mkdir -p $DATADIR/chainstate

docker run -itd --name bitcoind -p 8332:8332 -p 8333:8333 \
	$(test -d $DATADIR/blocks && echo -v $DATADIR/blocks:/home/docker/.bitcoin/blocks) \
	$(test -d $DATADIR/chainstate && echo -v $DATADIR/chainstate:/home/docker/.bitcoin/chainstate) \
	-e BITCOIND_RPCUSER=${RPCUSER} \
	-e BITCOIND_RPCPASSWORD=${RPCPASSWORD} \
	visvirial/bitcoind

