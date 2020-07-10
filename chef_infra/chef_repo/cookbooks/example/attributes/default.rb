#chef-client cookbook attributes
#number of seconds between chef-client daemon runs.
default['chef_client']['interval'] = '1800'
#random amount of seconds to add to interval.
default['chef_client']['splay'] = '0'

#audit attributes
default['audit']['reporter'] = 'chef-server-automate'
default['audit']['fetcher'] = 'chef-server'
default['audit']['profiles']['DevSec Linux Patch Benchmark'] = {
  'compliance': 'admin/linux-patch-baseline'
}

# default['linux_patching']['pre_config'] = {
#   'enable' => true,
#   'hour' => 3,
#   'minute' => 0,
#   'monthly' => nil,
#   'platforms' => 'all',
#   'reboot' => false,
#   'splay' => 0,
#   'weekly' => 'sunday',
#   'script' => ['echo yes'],
# }

# default['linux_patching']['patch'] = {
#   'enable' => true,
#   'hour' => 3,
#   'minute' => 0,
#   'monthly' => nil,
#   'platforms' => 'all',
#   'reboot' => false,
#   'splay' => 0,
#   'weekly' => 'sunday',
#   'script' => ['echo yes'],
# }

# default['linux_patching']['post_config'] = {
#   'enable' => true,
#   'hour' => 3,
#   'minute' => 0,
#   'monthly' => nil,
#   'platforms' => 'all',
#   'reboot' => false,
#   'splay' => 0,
#   'weekly' => 'sunday',
#   'script' => ['echo yes'],
# }


default['linux_patching']['pre_config'] = {
  'enable' => true,
  'hour' => 4,
  'minute' => 22,
  'monthly' => 'second wednesday',
  'platforms' => 'all',
  'reboot' => false,
  'splay' => 1,
  'weekly' => nil,
  'script' => ['echo pre-patching > /pre_patch.log'],
}

default['linux_patching']['patch'] = {
  'enable' => true,
  'hour' => 4,
  'minute' => 49,
  'monthly' => 'second wednesday',
  'platforms' => 'all',
  'reboot' => false,
  'splay' => 1,
  'weekly' => nil,
  'script' => [
    '/bin/yum update -y',
    'rc=$?',
    'if [[ $rc != 0 ]]; then',
    '    echo failed > /patch.log',
    'fi',
    '/bin/yum clean all -y',
    'rc=$?',
    'if [[ $rc != 0 ]]; then',
    '    echo failed > /patch.log',
    'fi',
    '/sbin/reboot',
  ],
}

default['linux_patching']['post_config'] = {
  'enable' => true,
  'hour' => 4,
  'minute' => 40,
  'monthly' => 'second wednesday',
  'platforms' => 'all',
  'reboot' => false,
  'splay' => 1,
  'weekly' => nil,
  'script' => ['echo post-patching > /post_patch.log'],
}
