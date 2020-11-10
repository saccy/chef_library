default['linux_repository']['org_name'] = 'andrew_test_org'

case node['platform']
when 'centos'
    case node['platform_version'].to_i
    when 6
        default['linux_repository']['repo_files'] = [
            {
                description: "CentOS-6 - Extras",
                baseurl: "http://10.102.44.63/link/6/extras/x86_64/",
                enabled: true,
                gpgcheck: false,
                repositoryid: "wipro_extras6"
            },
            {
                description: "CentOS-6 - Base",
                baseurl: "http://10.102.44.63/link/6/os/x86_64/",
                enabled: true,
                gpgcheck: false,
                repositoryid: "wipro_base6"
            },
            {
                description: "CentOS-6 - Updates",
                baseurl: "http://10.102.44.63/link/6/updates/x86_64/",
                enabled: true,
                gpgcheck: false,
                repositoryid: "wipro_updates6"
            }
        ]
    when 7
        default['linux_repository']['repo_files'] = [
            {
                description: "Centos-7-extras",
                baseurl: "http://10.102.44.63/link/7/extras/x86_64/",
                enabled: true,
                gpgcheck: false,
                repositoryid: "wipro_extras"
            },
            {
                description: "Centos-7-Base",
                baseurl: "http://10.102.44.63/link/7/os/x86_64/",
                enabled: true,
                gpgcheck: false,
                repositoryid: "wipro_base"
            },
            {
                description: "Centos-7-Updates",
                baseurl: "http://10.102.44.63/link/7/updates/x86_64/",
                enabled: true,
                gpgcheck: false,
                repositoryid: "wipro_updates"
            }
        ]
    end
when 'redhat'
    case node['platform_version'].to_i
    when 6
        default['linux_repository']['repo_files'] = [
            {
                description: "Red Hat Enterprise Linux 6 Server (RPMs)",
                baseurl: "http://10.102.44.62/link/rhel-6-server-rpms/",
                enabled: true,
                gpgcheck: false,
                repositoryid: "wipro_rhel-6-server-rpms"   
            }
        ]
    when 7
        default['linux_repository']['repo_files'] = [
            {
                description: "Red Hat Enterprise Linux 7 Server (RPMs)",
                baseurl: "http://10.102.48.238/link/rhel-7-server-rpms/Packages/",
                enabled: true,
                gpgcheck: false,
                repositoryid: "wipro_rhel-7-server-rpms"   
            }
        ]
    end
when 'ubuntu'
    case node['platform_version'].to_i
    when 14
        default['linux_repository']['repo_files'] = [
            {
	            name: "wipro_trusty_main",
                uri: "http://10.102.48.236/link/ubuntu",
                distribution: "trusty",
                components: "main restricted universe multiverse",
                deb_src: false
            },
            {
	            name: "wipro_trusty_security",
                uri: "http://10.102.48.236/link/ubuntu",
                distribution: "trusty-security",
                components: "main restricted universe multiverse",
                deb_src: false
            },
            {
	            name: "wipro_trusty_updates",
                uri: "http://10.102.48.236/link/ubuntu",
                distribution: "trusty-updates",
                components: "main restricted universe multiverse",
                deb_src: false
            }
        ]
    when 16
        default['linux_repository']['repo_files'] = [
            {
	            name: "wipro_xenial_main",
                uri: "http://10.102.48.236/link/ubuntu",
                distribution: "xenial",
                components: "main restricted universe multiverse",
                deb_src: false
            },
            {
	            name: "wipro_xenial_security",
                uri: "http://10.102.48.236/link/ubuntu",
                distribution: "xenial-security",
                components: "main restricted universe multiverse",
                deb_src: false
            },
            {
	            name: "wipro_xenial_updates",
                uri: "http://10.102.48.236/link/ubuntu",
                distribution: "xenial-updates",
                components: "main restricted universe multiverse",
                deb_src: false
            }
        ]
    when 18
        default['linux_repository']['repo_files'] = [
            {
	            name: "wipro_bionic_main",
                uri: "http://10.102.50.45/repo/ubuntu",
                distribution: "bionic",
                components: "main restricted universe multiverse",
                deb_src: false
            },
            {
	            name: "wipro_bionic_security",
                uri: "http://10.102.50.45/repo/ubuntu",
                distribution: "bionic-security",
                components: "main restricted universe multiverse",
                deb_src: false
            },
            {
	            name: "wipro_bionic_updates",
                uri: "http://10.102.50.45/repo/ubuntu",
                distribution: "bionic-updates",
                components: "main restricted universe multiverse",
                deb_src: false
            }
        ]
    end
when 'oracle'
    case node['platform_version'].to_i
    when 6
        default['linux_repository']['repo_files'] = [
            {
                description: "Red Hat Enterprise Linux 6 Server (RPMs)",
                baseurl: "http://10.102.44.62/link/rhel-6-server-rpms/",
                enabled: true,
                gpgcheck: false,
                platform_version: "6",
                repositoryid: "wipro_oracle-6-server-rpms"   
            }
        ]
    when 7
        default['linux_repository']['repo_files'] = [
            {
                description: "Red Hat Enterprise Linux 7 Server (RPMs)",
                baseurl: "http://10.102.48.238/link/rhel-7-server-rpms/",
                enabled: true,
                gpgcheck: false,
                platform_version: "7",
                repositoryid: "wipro_oracle-7-server-rpms"   
            }
        ]
    end
# when 'suse'
#     case node['platform_version'].to_i
#     when 11

#     when 12

#     end
end