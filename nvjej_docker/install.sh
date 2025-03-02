#!/bin/bash

docker build -t jeportie/nvjej:latest .
./script/install_alias.sh
