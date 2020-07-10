#!/bin/bash

#TODO: case statement do distinguish between distros

chef_server=''
chef_client_pkg=''

cd /tmp/
curl -O http://${chef_server}:8080/${chef_client_pkg}
yum localinstall -y ${chef_client_pkg}

#if ubuntu
# dpkg -i chef_13.2.20-1_amd64.deb