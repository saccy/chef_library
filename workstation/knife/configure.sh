#!/bin/bash

#https://docs.chef.io/workstation/knife_setup/
#knife configure --help

set -e

server_user='andrewhudson' #Created when you installed and configured chef server
server_user_key='/ahudson.pem' #Created when you installed and configured chef server
server_url='https://ip-10-0-1-125.ap-southeast-2.compute.internal'
server_org='andrewsawesomeorg' #Created when you installed and configured chef server
server_org_validation_key='/orgkey-validator.pem' #Created when you installed and configured chef server
config_file='/config.rb' #An empty file

touch $config_file

knife configure \
    --user $server_user \
    --key $server_user_key \
    --server-url "${server_url}/organizations/${server_org}" \
    --validation-key $server_org_validation_key \
    --config $config_file \
    --verbose
    # --repository '' \
    # --yes \

knife ssl fetch
knife ssl check
