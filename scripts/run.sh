#!/bin/sh
set -eu
IFS=$(printf "\n\t")
# scratch=$(mktemp -d -t tmp.XXXXXXXXXX)
# atexit() {
#   rm -rf "$scratch"
# }
# trap atexit EXIT

set -a
. ./settings
./venv/bin/python3 -mgunicorn -b ${HOST}:${PORT} main:app
