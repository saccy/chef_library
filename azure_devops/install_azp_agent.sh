#!/bin/bash

#NOTES: this script is not in a usable state atm
#       this script must be run by non-root user with passwordless sudo access

#TODO: refactor to look for proxy env vars.

ado_url='' #https://dev.azure.com/<your_org>
ado_token='' #your PAT token
azp_pool='default' #azure devops agent pool
azp_agent_name='test' #give your agent a name
agent_version=$(curl -s https://github.com/microsoft/azure-pipelines-agent/releases | grep '<td>Linux x64</td>' -A1 | head -2 | cut -d '/' -f5 | tail -1)

#Download and install agent + dependencies
wget https://vstsagentpackage.azureedge.net/agent/${agent_version}/vsts-agent-linux-x64-${agent_version}.tar.gz
tar xvzf vsts-agent-linux-x64-${agent_version}.tar.gz
sudo ./bin/installdependencies.sh

#Configure the agent
if [[ -n $PROXY_URL && -n $PROXY_USER && -n $PROXY_PASS ]]; then
    echo "Connecting to ADO server: $AZP_URL
agent pool: $AZP_POOL
agent name: $AZP_AGENT_NAME
proxy url: $PROXY_URL
proxy user: $PROXY_USER"
    ./config.sh \
        --unattended \
        --url $AZP_URL \
        --auth pat \
        --token $AZP_TOKEN \
        --pool $AZP_POOL \
        --agent $AZP_AGENT_NAME \
        --replace \
        --acceptTeeEula \
        --proxyurl $PROXY_URL \
        --proxyusername $PROXY_USER \
        --proxypassword $PROXY_PASS
elif [[ -n $PROXY_URL && ! -n $PROXY_USER && ! -n $PROXY_PASS ]]; then 
    echo "Connecting to ADO server: $AZP_URL
agent pool: $AZP_POOL
agent name: $AZP_AGENT_NAME
proxy url: $PROXY_URL"
    ./config.sh \
        --unattended \
        --url $AZP_URL \
        --auth pat \
        --token $AZP_TOKEN \
        --pool $AZP_POOL \
        --agent $AZP_AGENT_NAME \
        --replace \
        --acceptTeeEula \
        --proxyurl $PROXY_URL
elif [[ ! -n $PROXY_URL && ! -n $PROXY_USER && ! -n $PROXY_PASS ]]; then 
    echo "Connecting to ADO server: $AZP_URL
agent pool: $AZP_POOL
agent name: $AZP_AGENT_NAME"
    ./config.sh \
        --unattended \
        --url $AZP_URL \
        --auth pat \
        --token $AZP_TOKEN \
        --pool $AZP_POOL \
        --agent $AZP_AGENT_NAME \
        --replace \
        --acceptTeeEula
fi

#Run the agent as a service
sudo ./svc.sh install
sudo ./svc.sh start
