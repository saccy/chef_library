#
# Cookbook:: example_inherit_env
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

#The env var we set to an encrypted databag value in 'example' cookbook is inheritied and interpolated here
file '/tmp/message' do
    content "#{ENV['HTTPEE_PROXY']}\n"
    mode '0644'
end
