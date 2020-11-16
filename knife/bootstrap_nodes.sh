#!/bin/bash

# TODO:
#   error checking on JSON fields
#   windows
#   test password option - print warning that password isn't recommended
#   handle optional policy groups/policies
#   async bootstrapping

usage() {
    echo "usage: ${0} -c [ssh||pw] -f </path/to/creds/file> -n </path/to/nodes.json>"
    echo "  -c <connection> SSH or user:password"
    echo "  -f <credentials file> Path to SSH file or a file containing password"
    echo "  -n <nodes JSON file> Path to JSON file containing node information"
    echo "  -h <help> Display this message"
    echo "example: ${0} -c ssh -f ~/.ssh/private_key -n /nodes.json"
    echo "example: ${0} -c pw -f ~/.creds/password -n /nodes.json"
    exit 1
}

pre_flight_checks() {
    if [[ $EUID -ne 0 ]]; then
        echo "[ERROR] This script must be run as root" 
        usage
    fi

    if [ ! -f $node_list ]; then
        echo "[ERROR] Node list file must exist"
        usage
    fi

    if [ ${#node_list[@]} == 0 ]; then
        echo '[ERROR] Empty list detected'
        usage
    fi

    if ! which knife > /dev/null 2>&1; then
        echo '[ERROR] knife cli not found'
        usage
    fi

    if ! which jq > /dev/null 2>&1; then
        echo '[ERROR] jq cli not found'
        usage
    fi

    if [[ ! -n $conn_type || ! -n $creds_file ]]; then
        echo "[ERROR] Missing a required parameter"
        usage
    fi
}

while getopts "c:f:n:h" opt; do
    case $opt in
        'c')
            if [[ $OPTARG == 'ssh' || $OPTARG == 'pw' ]]; then
                conn_type=${OPTARG}
            else
                echo "[ERROR] Invalid connection type choice: $OPTARG"
                echo "Valid choices are ssh, pw"
                usage
            fi
            ;;
        'f')
            if [ -f $OPTARG ]; then
                creds_file=${OPTARG}
            else
                echo "[ERROR] Invalid file: $OPTARG"
                echo "Ensure file exists"
                usage
            fi
            ;;
        'n')
            if [ -f $OPTARG ]; then
                node_list=${OPTARG}
            else
                echo "[ERROR] Invalid file: $OPTARG"
                echo "Ensure file exists"
                usage
            fi
            ;;
        'h')
            usage
            ;;
        *)
            usage
            ;;
    esac
done

# Run pre-flight checks
pre_flight_checks

# Starting from 0
node_list_len=$(($(jq -r '.[] | length' $node_list) - 1))

# Bootstrap some nodes
case $conn_type in
    'ssh')
        END=${node_list_len}
        for ((i=0;i<=END;i++)); do
            node_dns=$(jq -r ".nodes[${i}].dns" $node_list)
            node_name=$(jq -r ".nodes[${i}].name" $node_list)
            node_port=$(jq -r ".nodes[${i}].port" $node_list)
            node_user=$(jq -r ".nodes[${i}].user" $node_list)
            policy_name=$(jq -r ".nodes[${i}].policy_name" $node_list)
            policy_group=$(jq -r ".nodes[${i}].policy_group" $node_list)
            
            if [ $node_port == 'null' ]; then
                node_port='22'
            fi

            # echo $node_dns
            # echo $node_name
            # echo $node_port
            # echo $policy_name
            # echo $policy_group
            # echo $user
            # echo $creds_file

            knife bootstrap $node_dns \
                --node-name $node_name \
                --connection-user $node_user \
                --ssh-identity-file $creds_file \
                --policy-name $policy_name \
                --policy-group $policy_group \
                --connection-port $node_port \
                --ssh-verify-host-key=never \
                --chef-license=accept \
                --sudo \
                -y
        done
        ;;
    'pw')
        END=${node_list_len}
        for ((i=0;i<=END;i++)); do
            node_dns=$(jq -r ".nodes[${i}].dns" $node_list)
            node_name=$(jq -r ".nodes[${i}].name" $node_list)
            node_port=$(jq -r ".nodes[${i}].port" $node_list)
            node_user=$(jq -r ".nodes[${i}].user" $node_list)
            policy_name=$(jq -r ".nodes[${i}].policy_name" $node_list)
            policy_group=$(jq -r ".nodes[${i}].policy_group" $node_list)

            if [ $node_port == 'null' ]; then
                node_port='22'
            fi

            knife bootstrap $node_dns \
                --node-name $node_name \
                --connection-user $node_user \
                --connection-password $(cat creds_file) \
                --policy-name $policy_name \
                --policy-group $policy_group \
                --connection-port $node_port \
                --chef-license=accept \
                --sudo \
                -y
        done
        ;;
    *)
        usage
        ;;
esac
