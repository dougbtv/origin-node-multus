#!/bin/bash

# Where's the file we are looking for
CONFIGURATION_FILEPATH="/etc/cni/net.d"
ORIGINAL_CONFIGURATION_FILENAME="80-openshift-network.conf"
MULTUS_CONFIGURATION_FILEPATH="/multus.conf"

# We're a hack so we can't really do anything cool in stdout
# so we'll write some output to a file for debug purposes.
OUTPUT_FILE=/tmp/watcher.output.log

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
    echo "found it!"
    found=true
  fi
done

# Check if we found anything, otherwise -- we must've timed out.
if [ "$found" = true ]; then
  # Copy in the configuration file.
  cp $MULTUS_CONFIGURATION_FILEPATH $CONFIGURATION_FILEPATH/$ORIGINAL_CONFIGURATION_FILENAME
  echo "Copy finished successfully @ $(time)" >> $OUTPUT_FILE
else
  # Output when we failed if we did.
  echo "Watcher timeout for Multus configuration installation @ $(time) after $MAX attempts at $WAIT_SECONDS second intervals" >> $OUTPUT_FILE
fi