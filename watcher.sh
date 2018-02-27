#!/bin/bash

# Where's the file we are looking for
configuration_filepath="/tmp"
configuration_filename="foo.conf"

# What are the looping parameters.
max="100"
count="0"
found=false

# Loop until found or count is reached.
while [ "$count" -lt "$max" ] && [ "$found" = false ]; do
  usleep 250000
  count=$[$count+1]
  echo $count
  ls -1 $configuration_filepath | grep -i "$configuration_filename"
  if [ $? == 0 ]; then
    echo "found it!"
    found=true
  fi
done

# until ls -1 /tmp/ | grep -m 1 "foo.conf"; echo $count; do : ; done
