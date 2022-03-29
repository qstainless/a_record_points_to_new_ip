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

# make it pretty
NC='\033[0m'     # No color
WHT='\033[1;37m' # White
BOLD=$(tput bold)
NORM=$(tput sgr0)

clear

# ask for the IP4 address to which your A record will point
echo "What is the target IP4 address? (xxx.xxx.xxx.xxx)"
read target_ip

target_ip=$target_ip:

# ask for the domain name pointing to the above IP4 address
echo "What is the domain to check for migration?"
read domain_to_check

interval=5

original_ip=$(ping -c 1 $domain_to_check | grep "64 bytes from"| awk '{print $4}')

echo "\nChecking for migration of ${BOLD}$domain_to_check${NORM}\nfrom ${WHT}${original_ip}${NC} to ${WHT}$target_ip${NC} at $interval-minute intervals.\n"

while true; do
    ip=$(ping -c 1 $domain_to_check | grep "64 bytes from"| awk '{print $4}')

    if [ "$ip" = "$target_ip" ]; then
        echo "\n${BOLD}Migration complete${NORM} @ ${WHT}$(date)${NC}";
        break;
    else
        echo "Still pointing to ${WHT}$ip${NC} @ $(date)"
    fi

    # Wait the interval value in minutes
    sleep $((60*interval))
done
