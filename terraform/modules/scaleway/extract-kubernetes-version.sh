#!/usr/bin/env bash

set -e

eval "$(jq -r '@sh "FOO=\(.file)"')"

version="$(cat "$file" | grep kubernetes | cut -d ' ' -f 3 | cut -d 'v' -f 2)"

jq -n --arg version "$version" '{"version":$version}'
