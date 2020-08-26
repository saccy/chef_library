#!/bin/bash
set -e

#TODO: get information from git data as to which repo has changed - get cookbook name from there dynicamally somehow
#      policyfile stuff

#artifacts dir is created by jenkins automatically during 'copy artifact' step
source ${WORKSPACE}/artifacts/var_artifact
export CHEF_LICENSE='accept'

cookbook_dir=${WORKSPACE}/chef/cookbooks
cd ${cookbook_dir}/challenge_cookbook/

###SYNTAX AND LINTING###
# echo 'running foodcritic'
# foodcritic .
echo 'running cookstyle'
cookstyle .

###Unit testing with ChefSpec###
#FIXME: can this be run outside the dir?
echo 'running ChefSpec'
#FIXME: use env var
#chef env --chef-license accept > /dev/null
chef exec rspec

###Integration testing with Kitchen + InSpec###
echo 'running InSpec via Kitchen'
#FIXME: ssh timed out
kitchen test
