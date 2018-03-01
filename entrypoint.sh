#!/bin/bash
# This is a blatant fake-out.
# It runs the watcher.sh to substitute Multus CNI configuration
# instead of the OpenShift SDN configuration for CNI
# It runs that, then runs the real entrypoint script.
/watcher.sh &> /dev/null &
/usr/local/bin/origin-node-run.sh "$@"