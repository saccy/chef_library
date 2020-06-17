#!/bin/bash

#https://docs.chef.io/workstation/knife_bootstrap/

set -e

node='' #DNS resolvable name of the node to target
node_user='' #The user on the node to authenticate as over SSH
node_ssh_key='' #Path to SSH key used to authenticate with node
node_name='' #The name your node will use when registering with CHEF server

#Need an SSH key to connect to the node
knife bootstrap $node \
    -U $node_user \
    --ssh-identity-file $node_ssh_key \
    --node-name $node_name \
    --chef-license=accept \
    --ssh-verify-host-key=never
