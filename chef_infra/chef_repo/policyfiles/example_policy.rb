# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

# A name that describes what the system you're building with Chef does.
name 'example_policy'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'recipe[example::default]'

# Specify a custom source for a single cookbook:
# cookbook 'chef-client', '~> 11.5.0', :supermarket
cookbook 'chef_client_updater', '~> 3.10.1', :supermarket
cookbook 'audit', '~> 9.4.0', :supermarket
cookbook 'linux_patching', '~> 0.1.2', :supermarket
cookbook 'example', path: '../cookbooks/example/'
# cookbook 'example_inherit_env', path: '../cookbooks/example_inherit_env/'
