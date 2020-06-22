#!/bin/bash
set -e

#NOTES: this script must be run by non-root user with passwordless sudo access

#TODO: cmd line args.
#      flag to force automatic rectify of preflight check errors and install

fqdn="$1"

curl https://packages.chef.io/files/current/latest/chef-automate-cli/chef-automate_linux_amd64.zip | \
    gunzip - > chef-automate && chmod +x chef-automate

#Initialise chef automate config file
sudo ./chef-automate init-config \
    --fqdn $fqdn #\
    #--certificate $cert \
    #--private-key $path_to_key

#FIXME: script will always exit here regardless of success or not
#Run preflight check
deploy_out="$(
    sudo ./chef-automate preflight-check \
        --config ./config.toml 2>&1 |
        tee /dev/tty
)"

#Check output of first deploy attempt and apply fixes automatically
if echo "$deploy_out" | grep ^vm. > /dev/null 2>&1; then
    echo "Applying sysctl changes"
    fixes="$(echo "$deploy_out" | grep ^vm.)"
    for fix in "${fixes[*]}"; do
        sudo sh -c "echo \"${fix}\" >> /etc/sysctl.conf"
    done
    sudo sysctl -p
    sudo ./chef-automate deploy config.toml --accept-terms-and-mlsa
fi
