#!/bin/bash
. ./bin/include/functions.sh

docker-compose $files_string up -d
