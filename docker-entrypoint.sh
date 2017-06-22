#!/bin/bash

set -o errexit

if [ -n "${RUST_SEED_FILE}" ]; then
  if [ -e "${RUST_SEED_FILE}" ]; then
	   RUST_SERVER_SEED=`cat ${RUST_SEED_FILE}`
     echo "Server Seed Override, Seed: "${RUST_SERVER_SEED}
  fi
fi

if [ "$1" = 'rust' ]; then
  exec /start.sh
else
  exec "$@"
fi
