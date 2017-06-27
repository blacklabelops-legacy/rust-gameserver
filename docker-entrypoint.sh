#!/bin/bash

set -o errexit

if [ -n "${RUST_SEED_FILE}" ]; then
  if [ -e "${RUST_SEED_FILE}" ]; then
	   RUST_SERVER_SEED=`cat ${RUST_SEED_FILE}`
     echo "Server Seed Override, Seed: "${RUST_SERVER_SEED}
  fi
fi

if [ -n "${RUST_WORLDSIZE_FILE}" ]; then
  if [ -e "${RUST_WORLDSIZE_FILE}" ]; then
	   RUST_SERVER_WORLDSIZE=`cat ${RUST_WORLDSIZE_FILE}`
     echo "Server Worldsize Override, Worldsize: "${RUST_SERVER_WORLDSIZE}
  fi
fi

if [ -n "${RUST_MAXPLAYERS_FILE}" ]; then
  if [ -e "${RUST_MAXPLAYERS_FILE}" ]; then
	   RUST_SERVER_MAXPLAYERS=`cat ${RUST_MAXPLAYERS_FILE}`
     echo "Server Max Players Override, Max Players: "${RUST_SERVER_MAXPLAYERS}
  fi
fi

if [ "$1" = 'rust' ]; then
  exec /start.sh
else
  exec "$@"
fi
