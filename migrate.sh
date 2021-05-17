#!/bin/zsh
# Description:
# This bash script will ping a server and check if the server's IP address
# matches the desired IP address.
#
# This is simple and useful script to monitor a domain's modified A record
# that points to a new hosting provider, instead of manually pinging
# the domain until propagation is complete. 
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

clear

# Replace xxx.xxx.xxx.xxx below with the IP to which your A record will point.
# target_ip is the IP address of your subdomain/domain in the target hosting provider.
# Keep the colon (:) at the end of the target_ip
target_ip="xxx.xxx.xxx.xxx:"
domain_to_check="subdomain.domain.com"
interval=5

echo "Checking for migration to $target_ip at $interval-minute intervals.\n"

while true; do
    ip=$(ping -c 1 $domain_to_check | grep "64 bytes from"| awk '{print $4}')

    if [ "$ip" = "$target_ip" ]; then
        echo "Migration complete @ $(date)";
        break;
    else
        echo "Still pointing to $ip @ $(date)"
    fi

    # Wait the interval value in minutes
    sleep $((60*interval))
done
