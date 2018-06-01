#!/bin/bash

# Where's the file we are looking for
CONFIGURATION_FILEPATH="/etc/cni/net.d"
ORIGINAL_CONFIGURATION_FILENAME="80-openshift-network.conf"
MULTUS_CONFIGURATION_FILEPATH="/multus.conf"

# We're a hack so we can't really do anything cool in stdout
# so we'll write some output to a file for debug purposes.
OUTPUT_FILE=/tmp/watcher.output.log

# Find where the kubeconfig is.
KUBECONFIG_FILE=$(find /etc/origin | grep -i kubeconfig)

# Substitute that into the config
sed -i -e "s|__REPLACE_WITH_KUBECONFIG__|$KUBECONFIG_FILE|" $MULTUS_CONFIGURATION_FILEPATH

# What are the looping parameters.
MAX="600"
WAIT_SECONDS="1"
COUNT="0"
found=false

# Loop until found or count is reached.
while [ "$COUNT" -lt "$MAX" ] && [ "$found" = false ]; do
  sleep $WAIT_SECONDS
  COUNT=$[$COUNT+1]
  ls -1 $CONFIGURATION_FILEPATH | grep -i "$ORIGINAL_CONFIGURATION_FILENAME"
  if [ $? == 0 ]; then
    echo "Config found @ $(date)" >> $OUTPUT_FILE
    found=true
  fi
done

# Check if we found anything, otherwise -- we must've timed out.
if [ "$found" = true ]; then
  # Copy in the configuration file.
  if cp $MULTUS_CONFIGURATION_FILEPATH $CONFIGURATION_FILEPATH/$ORIGINAL_CONFIGURATION_FILENAME; then
    echo "Copy finished successfully @ $(date)" >> $OUTPUT_FILE
  else
    echo "Copied failed to exit zero :( @ $(date)" >> $OUTPUT_FILE
  fi
else
  # Output when we failed if we did.
  echo "Watcher timeout for Multus configuration installation @ $(time) after $MAX attempts at $WAIT_SECONDS second intervals" >> $OUTPUT_FILE
fi