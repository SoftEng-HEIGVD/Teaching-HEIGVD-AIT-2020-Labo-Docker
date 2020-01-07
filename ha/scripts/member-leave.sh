#!/usr/bin/env bash

echo "Member leave/join script triggered" >> /var/log/serf.log

# We iterate over stdin
while read -a values; do
  # We extract the hostname, the ip, the role of each line and the tags
  HOSTNAME=${values[0]}
  HOSTIP=${values[1]}
  HOSTROLE=${values[2]}
  HOSTTAGS=${values[3]}

  echo "Member $SERF_EVENT event received from: $HOSTNAME with role $HOSTROLE" >> /var/log/serf.log
done
