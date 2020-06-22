#!/bin/bash
set -e

#Run this on CHEF server to connect to CHEF automate

automate_token=$1 #how to create a token: https://automate.chef.io/docs/api-tokens/#creating-api-tokens
automate_url=$2 #include leading http:// or https://, i.e. https://my_automate_server.mycompany.com
server_settings_file='/etc/opscode/chef-server.rb' #info on chef-server.rb: https://docs.chef.io/config_rb_server/

#Create /etc/opscode dir if it doesn't exist
if [ ! -d ${server_settings_file%/*} ]; then
    mkdir ${server_settings_file%/*}
fi

#Warn the user that there is an existing chef-server.rb file that will be appended to
if [ -f $server_settings_file ]; then
    echo "[WARN]: Appending changes to existing CHEF server non-default config file: $server_settings_file"
fi

#Set automate token on chef server
chef-server-ctl set-secret data_collector token $automate_token
chef-server-ctl restart nginx
chef-server-ctl restart opscode-erchef

#Insert automate config into /etc/opscode/chef-server.rb
echo "data_collector['root_url'] = '${automate_url}/data-collector/v0/'
data_collector['proxy'] = true
profiles['root_url'] = '${automate_url}'" > /etc/opscode/chef-server.rb

#Apply changes
chef-server-ctl reconfigure
