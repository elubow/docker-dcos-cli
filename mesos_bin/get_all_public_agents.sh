#!/usr/bin/env bash

set -o errexit -o nounset -o pipefail

echo "Finding IPs of all public agents..."

PUBLIC_AGENTS=$(dcos node --json | jq --raw-output '.[] | select(.attributes.public_ip == "true") | .id')

for id in ${PUBLIC_AGENTS[@]}; do
    echo "Working on: $id"
    IP=`dcos node ssh --option StrictHostKeyChecking=no --option LogLevel=quiet --master-proxy --mesos-id=$id "curl ifconfig.co"`
    echo "public IP: $IP"
done
