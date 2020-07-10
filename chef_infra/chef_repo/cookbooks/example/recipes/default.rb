#
# Cookbook:: example
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

# proxy = Chef::EncryptedDataBagItem.load("proxy", "password")

# ENV['HTTPEE_PROXY'] = "http://user:#{proxy['password']}@10.0.0.1:8080"

# include_recipe 'chef-client::default'

# chef_client_updater 'Install 16.2.50 and kill' do
#     version '16.2.50'
#     post_install_action 'kill'
# end

include_recipe 'audit::default'

include_recipe 'linux_patching::default'
