# linux_repository
Attribute based repository file management for rhel and debian based severs.

# How to use
 - Define your custom yum/apt repository files in the attributes file.
 - Any of the default or unmanaged repo's on your nodes will be moved into either `/etc/apt/archive` or `/etc/yum.repos.d_archive` depending on whether the node OS is debian or RHEL based, respectively.

# Roadmap
 - SUSE support
