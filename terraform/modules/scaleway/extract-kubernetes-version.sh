#!/usr/bin/env bash

set -e

version="$(grep k8s "$1" | cut -d ' ' -f 3 | cut -d 'v' -f 2)"

jq -n --arg version "$version" '{"version":$version}'
