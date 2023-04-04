#!/bin/bash
. ./bin/include/functions.sh

DOCKER_BUILDKIT=1 docker-compose $files_string up -d --build
