#!/bin/bash

chef install ../chef_infra/policfiles/example_policy.rb

#Apply a policy file to a node
#knife node policy set test-node 'test-policy-group-name' 'test-policy-name'
