# Linux patching
Tag based approach to patching with chef infra. The [linux_patch.sh](./templates/patch_linux.sh.erb) script runs the patching commands and is deployed and executed via the [default](./recipes/default.rb) recipe.

# Valid tags
 - `do_patch`: Patch a node. *Do not* reboot.
 - `do_patch_pre_reboot`: Patch a node. Reboot *before* patching.
 - `do_patch_post_reboot`: Patch a node. Reboot *after* patching.
 - `do_patch_all_reboot`: Patch a node. Reboot *before and after* patching.

# How to use
1. Include the cookbook in the runlist for your linux nodes.
1. Tag the nodes you want to patch with one of the valid tags from above.
1. Your nodes will log the output of the patching process locally to `/var/log/patching/<date of patching>`.
1. After patching, your nodes will be tagged with `patched_<date of patching>` which you can use to filter on in chef automate.

# Supported OS
 - Yum distro's - RHEL, CentOS, Oracle, etc.
 - Apt distro's - Debian, Ubuntu, etc.
 - Zypper distro's - SLES, OpenSUSE

# Limitations
 - Windows not supported
