#!/bin/bash
# set -e

#TODO: make cmd line args
#Pre-reqs: curl

#should run as root or with privilige escalation (sudo)

#Vars
user_first='andrew' #admin user first name
user_last='hudson' #admin user last name
user_name='andrewhudson' #admin user username: machine readable
user_email='ahudson@chef.io' #admin user email
user_pass='!Wjijnasiasc986'  #admin user password
user_key='/ahudson.pem' #path to store admin user SSH key (this will be generated automatically)
org='andrews awesome org' #name of your organisation
org_machine_friendly=$(echo "$org" | sed 's/ //g' | awk '{print tolower($0)}') #Remove spaces and case or org name
org_key='/orgkey-validator.pem' #path to store org SSH key (this will be generated automatically)
os=$(cat /etc/os-release | grep ^ID= | cut -d'=' -f2 | tr -d '"') #Get system OS
os_v=$(cat /etc/os-release | grep ^VERSION_ID= | cut -d'=' -f2 | tr -d '"') #Get system OS version
pkg_prefix='https://packages.chef.io/files/stable/chef-server'
server_vers=$(curl -sL https://downloads.chef.io | grep 'Chef Infra Server' | grep -oe 'Version [0-9]\+.[0-9]\+.[0-9]\+' | cut -d' ' -f2) #Get latest chef server version

#Only centos and ubuntu supported by this script
case $os in
    'centos')
        #https://downloads.chef.io/chef-server/${server_vers}#el  << use this to get the '${server_vers}-x' suffix
        pkg_suffix="${server_vers}/el/${os_v}/chef-server-core-${server_vers}-1.el7.x86_64.rpm"
        pkg_url=${pkg_prefix}/${pkg_suffix}
        pkg=${pkg_url##*/}
        curl $pkg_url -o /tmp/${pkg}
        yum localinstall -y /tmp/${pkg}
        ;;
    'ubuntu')
        #"https://downloads.chef.io/chef-server/${server_vers}#ubuntu" << use this to get the '${server_vers}-x' suffix
        pkg_suffix="${server_vers}/ubuntu/${os_v}/chef-server-core_${server_vers}-1_amd64.deb"
        pkg_url=${pkg_prefix}/${pkg_suffix}
        pkg=${pkg_url##*/}
        curl $pkg_url -o /tmp/${pkg}
        dpkg -i /tmp/${pkg}
        ;;
    *)
        echo "OS not supported in this environment: $os"
        exit 1
        ;;
esac

#Configure chef server
echo 'Accepting chef license'
chef-server-ctl \
    reconfigure \
        --chef-license=accept

echo 'Creating chef server admin user'
chef-server-ctl \
    user-create \
        $user_name \
        $user_first \
        $user_last \
        $user_email \
        $user_pass \
        --filename $user_key

# echo 'Creating chef server organisation'
chef-server-ctl \
    org-create \
        ${org_machine_friendly} \
        "$org" \
        --association_user $user_name \
        --filename $org_key
