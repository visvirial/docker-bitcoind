docker-bitcoind
===============

## Install

### Docker Hub

Just pull the docker image from Docker Hub.

``` bash
$ docker pull visvirial/bitcoind
```

### Building By Yourself

Alternatively, you can build the docker image on your own.

``` bash
$ docker build --tag=visvirial:bitcoind .
```

## Run

You can simply launching the container:

``` bash
$ docker run -itd --name bitcoind -p 8332:8332 -p 8333:8333 visvirial/bitcoind
```

However, it is strongly recommended that you change the user and password for RPC access
(change `${RPCUSER}` and `${RPCPASSWORD}` below).

``` bash
$ docker run -itd --name bitcoind -p 8332:8332 -p 8333:8333 \
	-e BITCOIND_RPCUSER=${RPCUSER} \
	-e BITCOIND_RPCPASSWORD=${RPCPASSWORD} \
	visvirial/bitcoind
```

Bitcoin Core will sync every time you launch the container, which consumes much CPU resources and time.
In order to skip the initial sync, you can mount and share the data directory.

``` bash
$ export DATADIR=/path/to/data/directory
$ docker run -itd --name bitcoind -p 8332:8332 -p 8333:8333 \
	$(test -d $DATADIR/blocks && echo -v $DATADIR/blocks:/home/docker/.bitcoin/blocks) \
	$(test -d $DATADIR/chainstate && echo -v $DATADIR/chainstate:/home/docker/.bitcoin/chainstate) \
	-e BITCOIND_RPCUSER=${RPCUSER} \
	-e BITCOIND_RPCPASSWORD=${RPCPASSWORD} \
	visvirial/bitcoind
```

Customize `launch-docker.sh` script to fit your environment.

## Using RPC

You can use `bitcoin-cli` to invoke RPC calls from the host machine as follows.

``` bash
$ bitcoin-cli -rpcuser=${RPCUSER} -rpcpassword=${RPCPASSWORD} getinfo
```



