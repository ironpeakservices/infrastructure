#!/usr/bin/env bash

set -e

version="$(echo "$1" | grep kubernetes | cut -d ' ' -f 3 | cut -d 'v' -f 2)"

jq -n --arg version "$version" '{"version":$version}'
