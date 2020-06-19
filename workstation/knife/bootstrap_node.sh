#!/bin/bash

#https://docs.chef.io/workstation/knife_bootstrap/

#TODO: include password option for authentication
#      cmd line flag for auth option

set -e

node='' #DNS resolvable name of the node to target
node_user='' #The user on the node to authenticate as over SSH
# node_ssh_key='' #Path to SSH key used to authenticate with node
node_password=''
node_name='' #The name your node will use when registering with CHEF server
policy_name=''
policy_group=''

knife bootstrap $node \
    --connection-user $node_user \
    --connection-password $node_password \
    --node-name $node_name \
    --policy-name $policy_name \
    --policy-group $policy_group \
    --chef-license=accept \
    --sudo
    # --ssh-verify-host-key=never \
    # --ssh-identity-file $node_ssh_key \
    # --connection-port
