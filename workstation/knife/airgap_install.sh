#!/bin/bash

#TODO: case statement do distinguish between distros

chef_server=''
chef_client_pkg=''

#TODO: add rhel 
if [[ $(cat /etc/os-release | grep ^ID= | cut -d'=' -f2 | tr -d '"') =~ ^(centos$|rhel$) ]]; then
    cd /
    curl -O http://${chef_server}:8080/${chef_client_pkg}
    yum localinstall -y ${chef_client_pkg}
else
    echo "Unsupported OS"
    exit 1
fi

#if ubuntu
# dpkg -i chef_13.2.20-1_amd64.deb
