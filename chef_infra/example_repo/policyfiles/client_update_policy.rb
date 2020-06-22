# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

# A name that describes what the system you're building with Chef does.
name 'client_update_policy'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'client_update::default'

# Specify a custom source for a single cookbook:
cookbook 'chef_client_updater', '~> 3.10.1', :supermarket
cookbook 'client_update', path: '../cookbooks/client_update/'

# Policyfile defined attributes
default['base']['message'] = "This node was audited by Chef.\nPolicyfile created at #{Time.now.utc}\n"
