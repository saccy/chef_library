#!/bin/bash

# AWS specific
host_name="$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)"

# Generate csr and key
openssl \
    req \
        -new \
        -newkey rsa:2048 \
        -nodes \
        -keyout ${host_name}.key \
        -out ${host_name}.csr

# Create the cert
openssl \
    x509 \
        -signkey ${host_name}.key \
        -in ${host_name}.csr \
        -req \
        -days 365 \
        -out ${host_name}.crt

echo "[[global.v1.frontend_tls]]
# The TLS certificate for the load balancer frontend.
cert = \"\"\"$(cat ${host_name}.crt)\"\"\"

key = \"\"\"$(cat ${host_name}.key)\"\"\"" > cert.toml

chef-automate config patch cert.toml

chef-automate config show
