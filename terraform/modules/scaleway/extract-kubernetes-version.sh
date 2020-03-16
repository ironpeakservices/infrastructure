#!/usr/bin/env bash

cat "$1" | grep kubernetes | cut -d ' ' -f 3 | cut -d 'v' -f 2
