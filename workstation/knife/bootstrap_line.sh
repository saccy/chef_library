#!/bin/bash

#TODO: add ssh key option

source ./node_list
node_user='chefadmin'
node_pass=$NODE_PASSWORD
proxy=''
proxy_user=''
proxy_pass=$PROXY_PASSWORD
chef_dir='/etc/chef'
databag_key='encrypted_data_bag_secret'

for node in ${node_list[@]}; do
    node_dns=$(echo $node | cut -d',' -f1) #DNS resolvable name of the node to target
    node_name=$(echo $node | cut -d',' -f2) #The name your node will use when registering with CHEF server
    policy_name='linux_baseline_policy'
    policy_group='linux_baseline'

    #Create chef dir on target node
    sudo sshpass -p $node_pass ssh \
        -o UserKnownHostsFile=/dev/null \
        -o StrictHostKeyChecking=no \
        ${node_user}@${node_dns} sudo mkdir $chef_dir

    #Copy databag key to tmp dir on target node
    sudo sh -c "sshpass -p $node_pass scp \
        -o UserKnownHostsFile=/dev/null \
        -o StrictHostKeyChecking=no \
        ${chef_dir}/${databag_key} \
        ${node_user}@${node_dns}:/tmp/${databag_key}"

    #Move databag key from tmp dir to chef dir on target node
    sshpass -p $node_pass ssh \
        -o UserKnownHostsFile=/dev/null \
        -o StrictHostKeyChecking=no \
        ${node_user}@${node_dns} sudo mv /tmp/${databag_key} ${chef_dir}/${databag_key}

    sudo knife bootstrap $node_dns \
        --node-name $node_name \
        --connection-user $node_user \
        --connection-password $node_pass \
        --policy-name $policy_name \
        --policy-group $policy_group \
        --bootstrap-proxy $proxy \
        --bootstrap-proxy-pass $proxy_pass \
        --bootstrap-proxy-user $proxy_user \
        --chef-license=accept \
        --sudo \
        -y
done
