default['linux_repository']['org_name'] = 'andrew_test_org'

case node['platform']
when 'centos'
  case node['platform_version'].to_i
  when 6
    default['linux_repository']['repo_files'] = [
        {
            description: 'chef-centos-6-extras',
            baseurl: 'http://10.0.0.1/link/6/extras/x86_64/',
            enabled: true,
            gpgcheck: false,
            repositoryid: 'chef-centos-6-extras',
        },
        {
            description: 'chef-centos-6-base',
            baseurl: 'http://10.0.0.1/link/6/os/x86_64/',
            enabled: true,
            gpgcheck: false,
            repositoryid: 'chef-centos-6-base',
        },
        {
            description: 'chef-centos-6-updates',
            baseurl: 'http://10.0.0.1/link/6/updates/x86_64/',
            enabled: true,
            gpgcheck: false,
            repositoryid: 'chef-centos-6-updates',
        },
    ]
  when 7
    default['linux_repository']['repo_files'] = [
        {
            description: 'chef-centos-7-extras',
            baseurl: 'http://10.0.0.1/link/7/extras/x86_64/',
            enabled: true,
            gpgcheck: false,
            repositoryid: 'chef-centos-7-extras',
        },
        {
            description: 'chef-centos-7-base',
            baseurl: 'http://10.0.0.1/link/7/os/x86_64/',
            enabled: true,
            gpgcheck: false,
            repositoryid: 'chef-centos-7-base',
        },
        {
            description: 'chef-centos-7-updates',
            baseurl: 'http://10.0.0.1/link/7/updates/x86_64/',
            enabled: true,
            gpgcheck: false,
            repositoryid: 'chef-centos-7-updates',
        },
    ]
  end
when 'redhat'
  case node['platform_version'].to_i
  when 6
    default['linux_repository']['repo_files'] = [
        {
            description: 'chef-rhel-6-server-rpms',
            baseurl: 'http://10.0.0.1/link/rhel-6-server-rpms/',
            enabled: true,
            gpgcheck: false,
            repositoryid: 'chef-rhel-6-server-rpms',
        },
    ]
  when 7
    default['linux_repository']['repo_files'] = [
        {
            description: 'chef-rhel-7-server-rpms',
            baseurl: 'http://10.0.0.1/link/rhel-7-server-rpms/Packages/',
            enabled: true,
            gpgcheck: false,
            repositoryid: 'chef-rhel-7-server-rpms',
        },
    ]
  end
when 'ubuntu'
  case node['platform_version'].to_i
  when 14
    default['linux_repository']['repo_files'] = [
        {
            name: 'chef-trusty-main',
            uri: 'http://10.0.0.1/link/ubuntu',
            distribution: 'trusty',
            components: 'main restricted universe multiverse',
            deb_src: false,
        },
        {
            name: 'chef-trusty-security',
            uri: 'http://10.0.0.1/link/ubuntu',
            distribution: 'trusty-security',
            components: 'main restricted universe multiverse',
            deb_src: false,
        },
        {
            name: 'chef-trusty-updates',
            uri: 'http://10.0.0.1/link/ubuntu',
            distribution: 'trusty-updates',
            components: 'main restricted universe multiverse',
            deb_src: false,
        },
    ]
  when 16
    default['linux_repository']['repo_files'] = [
        {
            name: 'chef-xenial-main',
            uri: 'http://10.0.0.1/link/ubuntu',
            distribution: 'xenial',
            components: 'main restricted universe multiverse',
            deb_src: false,
        },
        {
            name: 'chef-xenial-security',
            uri: 'http://10.0.0.1/link/ubuntu',
            distribution: 'xenial-security',
            components: 'main restricted universe multiverse',
            deb_src: false,
        },
        {
            name: 'chef-xenial-updates',
            uri: 'http://10.0.0.1/link/ubuntu',
            distribution: 'xenial-updates',
            components: 'main restricted universe multiverse',
            deb_src: false,
        },
    ]
  when 18
    default['linux_repository']['repo_files'] = [
        {
            name: 'chef-bionic-main',
            uri: 'http://10.0.0.1/repo/ubuntu',
            distribution: 'bionic',
            components: 'main restricted universe multiverse',
            deb_src: false,
        },
        {
            name: 'chef-bionic-security',
            uri: 'http://10.0.0.1/repo/ubuntu',
            distribution: 'bionic-security',
            components: 'main restricted universe multiverse',
            deb_src: false,
        },
        {
            name: 'chef-bionic-updates',
            uri: 'http://10.0.0.1/repo/ubuntu',
            distribution: 'bionic-updates',
            components: 'main restricted universe multiverse',
            deb_src: false,
        },
    ]
  end
when 'oracle'
  case node['platform_version'].to_i
  when 6
    default['linux_repository']['repo_files'] = [
        {
            description: 'chef-oracle-6-server-rpms',
            baseurl: 'http://10.0.0.1/link/rhel-6-server-rpms/',
            enabled: true,
            gpgcheck: false,
            platform_version: '6',
            repositoryid: 'oracle-6-server-rpms',
        },
    ]
  when 7
    default['linux_repository']['repo_files'] = [
        {
            description: 'chef-oracle-7-server-rpms',
            baseurl: 'http://10.0.0.1/link/rhel-7-server-rpms/',
            enabled: true,
            gpgcheck: false,
            platform_version: '7',
            repositoryid: 'oracle-7-server-rpms',
        },
    ]
  end
  # when 'suse'
  #     case node['platform_version'].to_i
  #     when 11

  #     when 12

  #     end
end