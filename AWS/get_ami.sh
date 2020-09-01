#!/bin/sh

#TODO: provide choice for oldest or newest

usage() {
    echo "usage: ${0} -d [centos||ubuntu]"
    echo "  -d <distro> centos or ubuntu"
    echo "  -h <help> Display this message"
    echo "example: ${0} -d centos"
    exit 1
}

profile='chef-engineering'
region='ap-southeast-2'

while getopts "d:h" opt; do
    case $opt in
        'd')
            case $OPTARG in
                'centos')
                    distro=${OPTARG}
                    owner_id='679593333241'
                    name='CentOS Linux 7 x86_64 HVM*'

                    echo "Printing the most recent $distro AMI"
                    aws ec2 describe-images \
                        --owners $owner_id \
                        --filters "Name=name,Values=${name}*" \
                        --query 'Images[*].[ImageId,CreationDate]' \
                        --output text \
                        --profile $profile \
                        --region $region | \
                        sort -k2 -r | \
                        head -n1
                    ;;
                'ubuntu')
                    distro=${OPTARG}
                    name='ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64*'

                    echo "Printing the most recent $distro AMI"
                    aws ec2 describe-images \
                        --filters "Name=name,Values=${name}*" \
                        --query 'Images[*].[ImageId,CreationDate]' \
                        --output text \
                        --profile $profile \
                        --region $region | \
                        sort -k2 -r | \
                        head -n1
                    ;;
                esac
            ;;
        'h')
            usage
            ;;
        *)
            echo "Invalid flag: \"-${OPTARG}\"" >&2
            usage
            ;;
    esac
done

if [[ ! -n $distro ]]; then
    echo "Missing a required parameter"
    usage
fi


#aws ec2 describe-images --owners self amazon --filters "Name=name,Values=*2012*" --query 'reverse(sort_by(Images, &CreationDate))[].[Name, ImageId, CreationDate, Description]
