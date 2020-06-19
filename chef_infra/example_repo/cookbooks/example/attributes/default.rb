#audit cookbook attributes
default['audit']['reporter'] = 'chef-server-automate'
default['audit']['fetcher'] = 'chef-server'
default['audit']['profiles'] = [
  {
    name: 'DevSec Linux Patch Benchmark',
    compliance: 'admin/linux-patch-baseline',
  },
]

#chef-client cookbook attributes
#number of seconds between chef-client daemon runs.
default['chef_client']['interval'] = '1800'
#random amount of seconds to add to interval.
default['chef_client']['splay'] = '300'
