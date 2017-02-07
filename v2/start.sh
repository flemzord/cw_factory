#!/usr/bin/env bash

PWD=$(pwd)
Directory=$(dirname $0)
echo "${Directory}"
echo "${PWD}"

fly -t lite login -c http://84.39.39.214:8080

fly set-pipeline --target lite --config ${PWD}/${Directory}/v2.yml --pipeline v3 --load-vars-from ~/credentials.yml
