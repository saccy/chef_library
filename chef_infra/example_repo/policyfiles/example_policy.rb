# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile.html

# A name that describes what the system you're building with Chef does.
name 'example_policy'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'example::default'

# Specify a custom source for a single cookbook:
cookbook 'audit', '~> 9.4.0', :supermarket
cookbook 'chef-client', '~> 11.5.0', :supermarket
cookbook 'example', path: '../cookbooks/example/'

# Policyfile defined attributes
default['base']['message'] = "This node was audited by Chef.\nPolicyfile created at #{Time.now.utc}\n"
