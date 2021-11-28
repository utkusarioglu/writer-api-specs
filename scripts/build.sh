#!/bin/sh
. "${0%/*}"/generate.sh

# This file is where generator commands are aggregated. Any api code
# that this repo is expected to create shall be called in this script
# file

generate "gateway" "v1" "typescript-fetch" "./typescript-fetch.json"
