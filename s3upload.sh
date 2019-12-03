#!/bin/sh

DIR=$(dirname "$1")
aws s3 cp ${DIR} s3://logs.loadbalancer2.sethserver.com --exclude "*" --include "*.gz"
