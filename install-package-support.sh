#!/bin/bash

# add the Cloudera 5 repo to install CDH 5.11 by default or use $CDH_VERSION
if [[ -z "${CDH_VERSION}" ]]; then
  __CDH_VERSION='5.11.0'
else
  __CDH_VERSION=$CDH_VERSION
fi

echo 'Adding Cloudera 5 repository ...'
echo "deb [arch=amd64] http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh trusty-cdh5.11.0 contrib
deb-src http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh trusty-cdh5.11.0 contrib" > /etc/apt/sources.list.d/cloudera.list
curl -s http://archive.cloudera.com/cdh5/ubuntu/trusty/amd64/cdh/archive.key | apt-key add -

# update the apt-cache
apt-get update

# install hadoop
apt-get install -y hadoop-hdfs
