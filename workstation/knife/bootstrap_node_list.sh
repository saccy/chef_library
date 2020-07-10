#!/bin/bash

node_list=(
    'ec2-3-104-30-99.ap-southeast-2.compute.amazonaws.com,ec2-3-104-30-99.ap-southeast-2.compute.amazonaws.com,ec2-user,/node_key',
    'ec2-13-239-9-128.ap-southeast-2.compute.amazonaws.com,ec2-13-239-9-128.ap-southeast-2.compute.amazonaws.com,ubuntu,/node_key'
)

for node in ${node_list[@]}; do
    node_dns=$(echo $node | cut -d',' -f1) #DNS resolvable name of the node to target
    node_name=$(echo $node | cut -d',' -f2) #The name your node will use when registering with CHEF server
    node_user=$(echo $node | cut -d',' -f3) #The user on the node to authenticate as over SSH
    node_ssh_key=$(echo $node | cut -d',' -f4) #The password for the user on the node to authenticate as over SSH
    policy_name='example_policy'
    policy_group='example_policy_group'

    knife bootstrap $node_dns \
        --node-name $node_name \
        --connection-user $node_user \
        --ssh-identity-file $node_ssh_key \
        --policy-name $policy_name \
        --policy-group $policy_group \
        --max-wait 10 \ #Try for a max of 10 seconds to connect via SSH
        --session-timeout 60 \
        --ssh-verify-host-key=never \
        --chef-license=accept \
        -y \
        --sudo
done
