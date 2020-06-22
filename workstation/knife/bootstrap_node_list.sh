#!/bin/bash

node_list=(
    '10.235.112.15,AZSG-D-TSAPERP3,rootuser,<password>'
)

for node in ${node_list[@]}; do
    node_dns=$(echo $node | cut -d',' -f1) #DNS resolvable name of the node to target
    node_name=$(echo $node | cut -d',' -f2) #The name your node will use when registering with CHEF server
    node_user=$(echo $node | cut -d',' -f3) #The user on the node to authenticate as over SSH
    node_password=$(echo $node | cut -d',' -f4) #The password for the user on the node to authenticate as over SSH
    policy_name='linux_baseline_policy'
    policy_group='linux_baseline'

    knife bootstrap $node_dns \
        --connection-user $node_user \
        --connection-password $node_password \
        --node-name $node_name \
        --policy-name $policy_name \
        --policy-group $policy_group \
        --chef-license=accept \
        --sudo
done
