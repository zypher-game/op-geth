#!/bin/bash

DATA_DIR="./data"

# look for empty dir
if [ "$(ls -A $DIR)" ]; then
    echo "$DIR is not Empty"
else
    echo "$DIR is Empty"
    build/bin/geth init --datadir="$DATA_DIR" ./genesis.json
fi

build/bin/geth \
--datadir="$DATA_DIR" \
--port "30303" \
--http \
--http.corsdomain="*" \
--http.vhosts="*" \
--http.addr="0.0.0.0" \
--http.port="8545" \
--http.api=web3,debug,eth,txpool,net,engine \
--ws \
--ws.addr "0.0.0.0" \
--ws.port "8546" \
--ws.api=web3,debug,eth,txpool,net,engine \
--ws.origins "*" \
--syncmode=full \
--gcmode=archive \
--nodiscover \
--maxpeers=0 \
