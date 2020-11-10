FROM centos:latest

ENV workstation_version /tmp/workstation_version

RUN curl -s https://downloads.chef.io/products/workstation?os=el | grep -m1 -o -P 'https://packages.chef.io/files/stable/chef-workstation/\S+/el/8/chef-workstation-\S+.x86_64.rpm' | head -1 | cut -d'"' -f1 | cut -d'/' -f7 > ${workstation_version}

RUN yum install -y https://packages.chef.io/files/stable/chef-workstation/$(cat ${workstation_version})/el/8/chef-workstation-$(cat ${workstation_version})-1.el7.x86_64.rpm
