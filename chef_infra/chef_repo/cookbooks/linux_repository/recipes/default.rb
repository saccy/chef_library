#
# Cookbook:: linux_repository
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# case node['platform_family']

# when 'debian'
#   directory '/etc/apt/archive' do
#     owner   'root'
#     mode    '0755'
#     action  :create
#   end

#   template '/etc/apt/archive_unmanaged_repos.sh' do
#     source 'archive_unmanaged_repos.sh.erb'
#     mode   '0755'
#     variables(
#       repo_dir: '/etc/apt/sources.list.d',
#       archive_dir: '/etc/apt/archive',
#       os_fam: node['platform_family']
#     )
#   end

#   execute 'archive existing repos' do
#     command '/etc/apt/archive_unmanaged_repos.sh'
#     not_if <<-EOH
#     repo_count=`/usr/bin/find /etc/apt/sources.list.d -type f -not -name "wipro_*" | /usr/bin/wc -l`
#     if [ $repo_count -ne 0 ]
#       then false
#     else
#       true
#     fi
#     EOH
#   end

#   execute 'archive sources file' do
#     command 'mv /etc/apt/sources.list /etc/apt/archive/sources.list.backup'
#     only_if { ::File.exist?('/etc/apt/sources.list') }
#   end

#   search(:"#{node['platform']}_repolist", '*:*').each do |repo_data|
#     next unless node['platform_version'] == repo_data['platform_version']
#     apt_repository  repo_data['id'] do
#       uri           repo_data['uri']
#       arch          'amd64'
#       distribution  repo_data['distribution']
#       components    [repo_data['components']]
#       cache_rebuild false
#     end
#   end

# when 'rhel'
#   directory '/etc/yum.repos.d_archive' do
#     owner 'root'
#     mode '0755'
#     action :create
#   end

#   template '/etc/yum/archive_unmanaged_repos.sh' do
#     source 'archive_unmanaged_repos.sh.erb'
#     mode   '0755'
#     variables(
#       repo_dir: '/etc/yum.repos.d',
#       archive_dir: '/etc/yum.repos.d_archive',
#       os_fam: node['platform_family']
#     )
#   end

#   execute 'archive existing repos' do
#     command '/etc/yum/archive_unmanaged_repos.sh'
#     not_if <<-EOH
#     repo_count=`/usr/bin/find /etc/yum.repos.d -type f -not -name "wipro_*" | /usr/bin/wc -l`
#     if [ $repo_count -ne 0 ]
#       then false
#     else
#       true
#     fi
#     EOH
#   end

#   if platform?('redhat')
#     execute 'disable rhn repo' do
#       command '/usr/sbin/subscription-manager config --rhsm.manage_repos=0'
#       only_if '/usr/sbin/subscription-manager config --list | grep \'manage_repos = \[1\]\''
#     end
#   end

#   search(:"#{node['platform']}_repolist", '*:*').each do |repo_data|
#     if node['platform_version'].to_i >= 6 && repo_data['platform_version'] == '6' && node['platform_version'].to_i < 7
#       yum_repository repo_data['id'] do
#         description repo_data['description']
#         baseurl repo_data['baseurl']
#         enabled repo_data['enabled']
#         gpgcheck repo_data['gpgcheck']
#         repositoryid repo_data['repositoryid']
#         action :create
#         make_cache false
#       end
#     elsif node['platform_version'].to_i >= 7 && repo_data['platform_version'] == '7'
#       yum_repository repo_data['id'] do
#         description repo_data['description']
#         baseurl repo_data['baseurl']
#         enabled repo_data['enabled']
#         gpgcheck repo_data['gpgcheck']
#         repositoryid repo_data['repositoryid']
#         action :create
#         make_cache false
#       end
#     end
#   end

# when 'suse'
#   if node['platform_version'].to_i == 11
#     node.default['zypper']['smt_host'] = 'chef-repo-SLESSAP12.wipro.com'
#     include_recipe 'zypper::smt_client'
#   end

#   if tagged?('GCP_TEST')
#     if node['platform_version'].to_i == 12

#       directory '/etc/zypp/repos.d/archive' do
#         owner  'root'
#         mode   '0755'
#         action :create
#       end

#       template '/etc/zypp/archive_unmanaged_repos.sh' do
#         source 'archive_unmanaged_repos.sh.erb'
#         mode   '0755'
#         variables(
#           repo_dir: '/etc/zypp/repos.d',
#           archive_dir: '/etc/zypp/repos.d/archive',
#           os_fam: node['platform_family']
#         )
#       end

#       template '/etc/zypp/reregister_smt.sh' do
#         source 'reregister_smt.sh.erb'
#         mode   '0755'
#         variables(
#           smt_host: 'chef-repo-SLESSAP12.wipro.com'
#         )
#         notifies :run, 'execute[archive existing repos]', :immediately
#         notifies :run, 'execute[re-register smt server]', :delayed
#       end

#       execute 'archive existing repos' do
#         command '/etc/zypp/archive_unmanaged_repos.sh'
#         action :nothing
#       end

#       execute 're-register smt server' do
#         command '/etc/zypp/reregister_smt.sh'
#         action :nothing
#       end

#     end

#   end

# end

node['linux_repository']['repo_files'].each do |repo_data|
  case node['platform_family']
  when 'rhel'
    yum_repository repo_data['description'] do
      description repo_data['description'] # becomes 'name' field in the repo file
      baseurl repo_data['baseurl']
      enabled repo_data['enabled']
      gpgcheck repo_data['gpgcheck']
      action :create
      make_cache false
    end
  when 'debian'
    apt_repository  repo_data['name'] do
      uri           repo_data['uri']
      arch          'amd64'
      distribution  repo_data['distribution']
      components    [repo_data['components']]
      cache_rebuild false
    end
  end
end
