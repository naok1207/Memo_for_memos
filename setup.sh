#!/bin/bash

set -eu

echo environment is ${RAILS_ENV:=development}

if [ ${RAILS_ENV} = "staging" -o ${RAILS_ENV} = "production" ]; then
  mkdir -p -m 777 tmp/pids
  mkdir -p -m 777 tmp/sockets
fi
