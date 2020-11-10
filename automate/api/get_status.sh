#!/bin/bash

automate_url='https://ec2-3-25-195-177.ap-southeast-2.compute.amazonaws.com'

# Create 'admin token'
admin_token=$(chef-automate iam token create --id admin_token admin_token --admin)

# Create 'token'
status_token=$(chef-automate iam token create --id status_token status_token)

# Create a policy that allows your 'token' to access the /status endpoint. Use 'admin token' to authenticate for this action
curl \
    -k \
    -H "api-token: $admin_token" \
    -d '{ 
        "name": "Monitoring",
        "id": "monitoring",
        "members": [
            "token:status_token"
        ],
        "statements": [
            {
                "effect": "ALLOW",
                "actions": [
                    "system:status:get"
                ],
                "projects": [
                    "*"
                ]
            }
        ]
    }' \
    -X POST ${automate_url}/apis/iam/v2/policies?pretty

# Test that your token and policy give you access to the /status endpoint
curl \
    -k \
    -H "api-token: $status_token" \
    ${automate_url}/api/v0/status?pretty
