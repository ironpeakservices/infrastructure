#!/usr/bin/env bash

#!/usr/bin/env bash

# Processing JSON in shell scripts
# https://www.terraform.io/docs/providers/external/data_source.html#processing-json-in-shell-scripts

# Exit if any of the intermediate steps fail
set -e

# Extract "host" argument from the input into HOST shell variable
eval "$(jq -r '@sh "HOST=\(.host) KEYPATH=\(.sshkeypath)"')"
if [ -z "$HOST" ]; then
    >&2 echo "Host parameter missing"
    exit 1
fi
if [ -z "$KEYPATH" ]; then
    >&2 echo "Key path parameter missing"
    exit 1
fi

# Fetch the manager join token
MANAGER=$(ssh -o StrictHostKeyChecking=no -o BatchMode=yes -o UserKnownHostsFile=/dev/null -i "$KEYPATH" \
    root@"$HOST" docker swarm join-token manager -q)

# Fetch the worker join token
WORKER=$(ssh -o StrictHostKeyChecking=no -o BatchMode=yes -o UserKnownHostsFile=/dev/null -i "$KEYPATH" \
    root@"$HOST" docker swarm join-token worker -q)

# Produce a JSON object containing the tokens
jq -n --arg manager "$MANAGER" --arg worker "$WORKER" \
    '{"manager":$manager,"worker":$worker}'
