#!/bin/zsh
# Description:
# This bash script will ping a server and check if the server's IP address
# matches the desired IP address.
#
# This is simple and useful script to monitor a domain's modified A record
# that points to a new hosting provider, instead of manually pinging
# the domain until propagation is complete.
#
# The script takes two arguments:
# target_ip - the IP address of the subdomain/domain in the target hosting provider to which the A record will point.
# domain_to_check - the subdomain/domain in the target hosting provider
#
# The script can also be modified to write the update messages to a text file
# ```
# echo "Migration complete @ $(date)" >> migration_check.txt
# ```
#
# and
#
# ```
# echo "Still pointing to $ip @ $(date)" >> migration_check.txt
# ```

# check if proper arguments are passed
if [ $# -eq 0 ]; then
  echo "No target ip address or domain provided."
  echo "usage: sh migrate.sh <target_ip_address> <target_domain_to_check>"
  exit 1
fi

clear

target_ip="$1:"
domain_to_check=$2

# interval to check in minutes
interval=5

echo "Checking for migration to $target_ip at $interval-minute intervals.\n"

while true; do
  ip=$(ping -c 1 $domain_to_check | grep "64 bytes from" | awk '{print $4}')

  if [ "$ip" = "$target_ip" ]; then
    echo "Migration complete @ $(date)"
    break
  else
    echo "Still pointing to $ip @ $(date)"
  fi

  # Wait the interval value in minutes
  sleep $((60 * interval))
done
