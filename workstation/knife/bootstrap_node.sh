#!/bin/bash

#https://docs.chef.io/workstation/knife_bootstrap/

#TODO: include password option for authentication
#      cmd line flag for auth option

set -e

node='172.17.0.3' #DNS resolvable name of the node to target
node_user='root' #The user on the node to authenticate as over SSH
node_ssh_key='/node_key' #Path to SSH key used to authenticate with node
node_password=''
node_name='local_docker_node' #The name your node will use when registering with CHEF server
policy_name='example_policy'
policy_group='example_policy_group'

knife bootstrap $node \
    --connection-user $node_user \
    --node-name $node_name \
    --policy-name $policy_name \
    --policy-group $policy_group \
    --ssh-identity-file $node_ssh_key \
    --ssh-verify-host-key=never \
    --node-ssl-verify-mode none \
    --chef-license=accept #\
    # --sudo
    # --connection-password $node_password \
    # --connection-port
