systemctl stop chef-client
yum remove -y chef
rm -rf {/etc/chef,/var/chef,/etc/systemd/system/multi-user.target.wants/chef-client.service,/etc/systemd/system/chef-client.service}
systemctl daemon-reload
