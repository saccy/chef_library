#!/bin/bash

#https://docs.chef.io/workstation/knife_setup/
#knife configure --help

set -e

server_user='' #Created when you installed and configured chef server
server_user_key='' #Created when you installed and configured chef server
server_url=''
server_org='' #Created when you installed and configured chef server
server_org_validation_key='' #Created when you installed and configured chef server
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

rm -f $config_file

knife ssl fetch
knife ssl check
