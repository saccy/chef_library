#!/bin/bash

#https://docs.chef.io/workstation/knife_bootstrap/

#TODO: include password option for authentication
#      cmd line flag for auth option

set -e

node='ec2-54-252-29-248.ap-southeast-2.compute.amazonaws.com' #DNS resolvable name of the node to target
node_user='centos' #The user on the node to authenticate as over SSH
node_ssh_key='/root/.ssh/ahudson' #Path to SSH key used to authenticate with node
node_password=''
node_name='centos_test' #The name your node will use when registering with CHEF server
policy_name='linux_baseline'
policy_group='linux_baseline'

knife bootstrap $node \
    --connection-user $node_user \
    --node-name $node_name \
    --ssh-identity-file $node_ssh_key \
    --ssh-verify-host-key=never \
    --node-ssl-verify-mode none \
    --chef-license=accept \
    --sudo \
    -y 
    # --policy-name $policy_name \
    # --policy-group $policy_group \    # --connection-password $node_password \
    # --connection-port
