# A name that describes what the system you're building with Chef does.
name 'linux_patching_policy'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'recipe[linux_repository::default]', 'recipe[linux_patching::default]'

# Specify a custom source for a single cookbook:
cookbook 'linux_repository', path: '../cookbooks/linux_repository/'
cookbook 'linux_patching', path: '../cookbooks/linux_patching/'
