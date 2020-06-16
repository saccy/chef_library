#!/bin/bash
set -e

automate_token=$1
automate_url=$2

sudo chef-server-ctl set-secret data_collector token $automate_token
sudo chef-server-ctl restart nginx
sudo chef-server-ctl restart opscode-erchef

if [ ! -d /etc/opscode ]; then
    mkdir /etc/opscode
fi

#Insert config data into /etc/opscode/chef-server.rb
sudo sh -c "echo \"data_collector['root_url'] = 'https://${automate_url}/data-collector/v0/'
data_collector['proxy'] = true
profiles['root_url'] = 'https://${automate_url}'\" > /etc/opscode/chef-server.rb"

sudo chef-server-ctl reconfigure
