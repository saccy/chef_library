# Specify the free storage for a partition in GB
default['linux_patching']['var_partition_min_diskspace_required_in_GB'] = 10

# audit cookbook attributes
# default['audit']['reporter'] = 'chef-server-automate'
# default['audit']['fetcher']  = 'chef-server'
# default['audit']['profiles'] = [
#   {
#     name: 'DevSec Linux Patch Benchmark',
#     compliance: 'admin/linux-patch-baseline',
#   },
# ]
