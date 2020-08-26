#!/bin/bash

chef_server=''
os=$(cat /etc/os-release | grep ^ID= | cut -d'=' -f2 | tr -d '"')
os_ver=$(cat /etc/os-release | grep ^VERSION_ID= | cut -d'=' -f2 | tr -d '"')

case $os in
    'centos'|'rhel'|'amzn'|'ol')
        chef_client_pkg='chef-16.2.73-1.el7.x86_64.rpm'
        curl -O http://${chef_server}:8080/${chef_client_pkg}
        yum localinstall -y $chef_client_pkg
        ;;
    'ubuntu'|'debian')
        chef_client_pkg='chef_16.2.73-1_amd64.deb'
        curl -O http://${chef_server}:8080/${chef_client_pkg}
        dpkg -i $chef_client_pkg
        ;;
    'sles')
        chef_client_pkg='chef-16.2.73-1.sles12.x86_64.rpm'
        curl -O http://${chef_server}:8080/${chef_client_pkg}
        zypper in -y $chef_client_pkg
        ;;
    *)
        echo "Unsupported OS: $os"
        exit 1
        ;;
esac
