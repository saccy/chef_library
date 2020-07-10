#!/bin/bash

#the custom install script needs to curl -O both the install script and the chef client pkg, and then yum localinstall the chef client pkg

#Start http gem server 8808
#https://github.com/feedforce/ruby-rpm/releases/
yum install -y https://github.com/feedforce/ruby-rpm/releases/download/2.7.1/ruby-2.7.1-1.el7.centos.x86_64.rpm
gem install mixlib-install
gem install mixlib-shellout
gem install mixlib-versioning
gem install inspec
gem server &> /dev/null &
gem_server_pid=$!
echo "gem server is running on port 8808, pid: $gem_server_pid"

#Start http file server 8080. Put chef client package and install script in this dir and make parent dir a+x
python -m SimpleHTTPServer 8080 &> /dev/null &
http_server_pid=$!
echo "file server is running on port 8080, pid: $http_server_pid"
