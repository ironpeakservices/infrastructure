#!/usr/bin/env bash

set -e

version="$(grep require "$1" | cut -d ' ' -f 3 | cut -d 'v' -f 2 | sed 's/^0/1/')"

if [ -z "$version" ]; then
    echo "error: could not find version in $1"
    exit 1
fi

jq -n --arg version "$version" '{"version":$version}'