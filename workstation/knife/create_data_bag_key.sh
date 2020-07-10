#!/bin/bash

#Run this on a workstation/chef server

#Create the encryption key
openssl rand -base64 512 | tr -d '\r\n' > /etc/chef/encrypted_data_bag_secret

#Delete the old one we created
knife data bag list
knife data bag delete <databag>

#Create an encrypted secret using the encryption key
knife data bag create proxy password --secret-file /etc/chef/encrypted_data_bag_secret
{
  "id": "password",
  "password": ""
}


#The encryption key must be copied to the node at /etc/chef/encrypted_data_bag_secret during bootstrap
ssh username@server sudo mkdir /etc/chef/ -i <ssh_key>
scp -i <ssh_key> username@server:/etc/chef/encrypted_data_bag_secret /etc/chef/encrypted_data_bag_secret

