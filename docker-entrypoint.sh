#!/bin/bash

set -o errexit

if [ "$1" = 'rust' ]; then
  exec /start.sh
else
  exec "$@"
fi
