#!/usr/bin/env bash

ls -al *
ls result/*

NOVA_ID=$(cat result/id.txt)
echo $NOVA_ID


#packer build packer_${OS_VERSION}.json