#!/bin/bash

# NOTE: this relies on the azure devops env var $BUILD_ARTIFACTSTAGINGDIRECTORY, you can set it to a local var if you'd like to test this.

chef_automate_url=${CHEF_AUTOMATE_URL}
chef_automate_token=${CHEF_AUTOMATE_TOKEN}

echo "Building list of missing nodes"

missing_nodes=$(
    curl \
        -s \
        --insecure \
        -H "api-token: $chef_automate_token" \
        "https://${chef_automate_url}/api/v0/cfgmgmt/nodes?pagination.page=1&pagination.size=100&sorting.field=name&sorting.order=ASC&filter=status:missing"
)

missing_node_list=($(echo $missing_nodes | jq -r '.[] | "\(.ipaddress),\(.name),\(.organization)"'))

echo 'Populating lists of missing nodes'
for missing_node in ${missing_node_list[@]}; do
    node_ip=$(echo $missing_node | cut -d',' -f1)
    node_name=$(echo $missing_node | cut -d',' -f2)
    node_org=$(echo $missing_node | cut -d',' -f3)

    # Populate missing node list files, ready for artifact publication
    echo "'${node_ip},${node_name}'" >> ${BUILD_ARTIFACTSTAGINGDIRECTORY}/${chef_server}_missing_node_list

done

for artifact in $(ls ${BUILD_ARTIFACTSTAGINGDIRECTORY}); do
    sed -i '1s;^;node_list=(\n;' $artifact
    echo ')' >> $artifact
done
