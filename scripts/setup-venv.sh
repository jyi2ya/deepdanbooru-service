#!/bin/sh
set -eu
IFS=$(printf "\n\t")
# scratch=$(mktemp -d -t tmp.XXXXXXXXXX)
# atexit() {
#   rm -rf "$scratch"
# }
# trap atexit EXIT

python3 -m venv --system-site-packages venv
. venv/bin/activate
pip install -U setuptools
pip install deepdanbooru-onnx
