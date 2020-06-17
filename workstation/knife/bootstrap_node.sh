#!/bin/bash

#https://docs.chef.io/workstation/knife_bootstrap/

set -e

node='chef_node' #DNS resolvable name of the node to target
node_user='root' #The user on the node to authenticate as over SSH
node_ssh_key='/node_key' #Path to SSH key used to authenticate with node
node_name='node1-centos' #The name your node will use when registering with CHEF server

#chef_node is defined during container runtime
#Need an SSH key to connect to the node
knife bootstrap $node \
    -U $node_user \
    --ssh-identity-file $node_ssh_key \
    --node-name $node_name \
    --chef-license=accept \
    --ssh-verify-host-key=never
