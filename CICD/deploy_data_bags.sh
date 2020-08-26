#!/bin/bash

# TODO: need to check if item has changed

# print bag, item, check if file changed, check if git has native md5 hashing

error_handler() {
    local exit_code="$1"
    local err_info="$2"
    if [ $exit_code != 0 ]; then
        echo "[ERROR]: $err_info"
        echo "Error code: $exit_code"
        exit $exit_code
    fi
}

data_bags_server=($(knife data bag list))
data_bags_dir='./chef_infra/chef_repo/data_bags'

# Check for new data bags in repo
for data_bag in $(ls ${data_bags_dir}); do
    if [[ ! " ${data_bags_server[@]} " =~ " ${data_bag} " ]]; then
        echo "Running command: knife data bag create $data_bag"
        knife data bag create $data_bag
        rc=$?
        error_handler $rc "error occurred during command: knife data bag create $data_bag"
    fi

    for item in $(ls ${data_bags_dir}/${data_bag}); do
        echo "Running command: knife data bag from file ${data_bag} ${data_bags_dir}/${data_bag}/${item}"
        knife data bag from file ${data_bag} ${data_bags_dir}/${data_bag}/${item}
        rc=$?
        error_handler $rc "error occurred during command: knife data bag from file $item ${data_bags_dir}/${data_bag}"
    done
done

# Check if data bags have been removed from repo, and should then be removed from chef server
for data_bag in ${data_bags_server[@]}; do
    if [[ ! " $(ls ${data_bags_dir}) " =~ " ${data_bag} " ]]; then
        echo "Running command: knife data bag delete $data_bag -y"
        knife data bag delete $data_bag -y
        rc=$?
        error_handler $rc "error occurred during command: knife data bag delete $data_bag -y"
    fi
done
