#!/bin/bash

echo '[deployment.v1.svc]
upgrade_strategy = "none"' > upgrade_strategy.toml

chef-automate config patch upgrade_strategy.toml
