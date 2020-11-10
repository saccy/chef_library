#!/bin/bash

backup_dir='/opt/backups'

mkdir /opt/backups

# Ensure the hab user has access to backup dir
chef-automate backup fix-repo-permissions $backup_dir

# Patch the config
echo "[global.v1.backups.filesystem]
  path = \"${backup_dir}\"" > backup.toml
chef-automate config patch backup.toml

# Create the backup
# backup_id=$(chef-automate backup create | awk '{print $NF}')
chef-automate backup create

# List all backups
chef-automate backup list

# To debug a failed backup, set the log level to debug and re-run the backup. This outputs the debug information to the Chef Automate log:
# chef-automate debug set-log-level deployment-service debug

# To restore on an existing Chef Automate host by overwriting the existing installation with the backup
# chef-automate backup restore ${backup_dir}/${backup_id} --skip-preflight
