#!/bin/bash

#NOTES: this script must be run by non-root user with passwordless sudo access

# ado_url='https://dev.azure.com/chef-sa'
ado_url='' #TODO
ado_token='' #TODO
azp_pool='default' #TODO
azp_agent_name='test' #TODO
agent_version=$(curl -s https://github.com/microsoft/azure-pipelines-agent/releases | grep '<td>Linux x64</td>' -A1 | head -2 | cut -d '/' -f5 | tail -1)

#Download and install agent + dependencies
wget https://vstsagentpackage.azureedge.net/agent/${agent_version}/vsts-agent-linux-x64-${agent_version}.tar.gz
tar xvzf vsts-agent-linux-x64-${agent_version}.tar.gz
sudo ./bin/installdependencies.sh

#Configure the agent
./config.sh \
    --unattended \
    --url $ado_url \
    --auth pat \
    --token $ado_token \
    --pool $azp_pool \
    --agent $azp_agent_name \
    --replace \
    --acceptTeeEula

#Run the agent as a service
sudo ./svc.sh install
sudo ./svc.sh start
