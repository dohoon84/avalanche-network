#!/bin/bash
mkdir -p staking/{node1,node2,node3,node4}

for node in {1..4}; do
  openssl req -x509 -newkey rsa:4096 \
    -keyout staking/node${node}/staker.key \
    -out staking/node${node}/staker.crt \
    -days 36500 -nodes \
    -subj "/CN=avalanche-node${node}/O=AvalancheL1"
done

chmod -R 755 staking/*

