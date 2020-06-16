#!/bin/bash
set -e

#TODO: make cmd line args

#Vars
user_first=''
user_last=''
user_email=''
user_pass=''
ssh_key=''
org=''
os=$(cat /etc/os-release | grep ^ID= | cut -d'=' -f2 | tr -d '"')
os_v=$(cat /etc/os-release | grep ^VERSION_ID= | cut -d'=' -f2 | tr -d '"')
pkg_prefix='https://packages.chef.io/files/stable/chef-server'

case $os in
    'centos')
        server_vers=$(curl -sL https://downloads.chef.io | grep 'Chef Infra Server' | grep -oe 'Version [0-9]\+.[0-9]\+.[0-9]\+' | cut -d' ' -f2)
        pkg_suffix="${server_vers}/el/${os_v}/chef-server-core-${server_vers}-1.el7.x86_64.rpm"
        install_cmd='yum localinstall -y'
        ;;
    'ubuntu')
        apt update
        apt install -y curl
        server_vers=$(curl -sL https://downloads.chef.io | grep 'Chef Infra Server' | grep -oe 'Version [0-9]\+.[0-9]\+.[0-9]\+' | cut -d' ' -f2)
        pkg_suffix="${server_vers}/ubuntu/${os_v}/chef-server-core_${server_vers}-1_amd64.deb"
        install_cmd='dpkg -i'
        ;;
    *)
        echo "OS not supported in this environment: $os"
        exit 1
        ;;
esac

pkg_url=${pkg_prefix}/${pkg_suffix}
pkg=${pkg_url##*/}

#Main
curl $pkg_url -o /tmp/${pkg}

exec $install_cmd /tmp/${pkg}

chef-server-ctl \
    reconfigure \
    --chef-license=accept

chef-server-ctl \
    user-create "${user_first}${user_last}" ${user_first} ${user_last} $user_email $user_pass \
    --filename /${ssh_key}

chef-server-ctl \
    org-create $(echo "$org" | sed 's/ //g' | awk '{print tolower($0)}') "$org" \
    --association_user ${user_first}${user_last} \
    --filename /$(echo "$org" | sed 's/ //g')-validator.pem
