#
# Cookbook:: linux_patching
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

if tagged('do_patch_pre_reboot')
  untag('do_patch_pre_reboot')
  tag('pre_reboot')
  tag('do_patch')
elsif tagged('do_patch_post_reboot')
  untag('do_patch_post_reboot')
  tag('post_reboot')
  tag('do_patch')
elsif tagged('do_patch_all_reboot')
  untag('do_patch_all_reboot')
  tag('pre_reboot')
  tag('post_reboot')
  tag('do_patch')
end

if tagged?('do_patch')
  log_dir = "/var/log/patching/#{Time.new.strftime("%Y-%m-%d")}"
  patch_script = '/patch_linux.sh'

  directory log_dir do
    action :create
    recursive true
  end

  # Reboots server only if notified
  reboot 'now' do
    action :nothing
    reason 'Chef has requested reboot.'
  end

  # Deploy patching script to server
  template patch_script do
    source 'patch_linux.sh.erb'
    mode   '0700'
    action :create
    variables(
        'log':     "#{log_dir}/patch.log",
        'os_fam':  node['platform_family'],
        'os_vers': node['platform_version'].to_i
      )
  end

  # Reboot before patching if specified
  if tagged?('pre_reboot')
    untag('pre_reboot')
    execute 'Pre patch reboot' do
      command "echo 'pre patch reboot underway'"
      notifies :reboot_now, 'reboot[now]', :immediately
    end
    
    # Stop processing client run here if pre_reboot is required.
    return
  end

  untag('do_patch')
  tag("patched_#{Time.new.strftime("%Y-%m-%d")}")

  var_partition_available_size = `df -h /var | sed -n '2p' | awk '{print $4}' | cut -d"G" -f1`

  if var_partition_available_size.to_i > node['linux_patching']['var_partition_min_diskspace_required_in_GB']
    # Run the patching script
    execute 'Patch server' do
      command patch_script
    end

    # Reboot after patching if specified
    if tagged?('post_reboot')
      untag('post_reboot')
      execute 'Post patch reboot' do
        command "echo 'post patch reboot underway'"
        notifies :reboot_now, 'reboot[now]', :delayed
      end
    end

  else
    raise 'Can not patch node due to insufficient disk space'
  end

end
