#!/usr/bin/env sh

env_file=".env"

if [ -f "${env_file}" ]; then
  set -o allexport
  source "${env_file}"
  set +o allexport 
fi

pkill -f "fetch_loop.py"
pkill -f "viz_server.py"
nohup python -u fetch_loop.py 2>&1 > log_fetch.log &
nohup python -u viz_server.py 2>&1 > log_dash.log &
echo "OK"
tail -f log_fetch.log log_dash.log
