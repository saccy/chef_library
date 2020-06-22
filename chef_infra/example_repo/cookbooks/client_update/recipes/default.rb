#
# Cookbook:: client_update
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

chef_client_updater 'Install 16.2.44 and kill' do
    version '16.2.44'
    post_install_action 'kill'
end
