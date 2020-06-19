# a_record_points_to_new_ip
Small bash script to check if subdomain's A record points to the new IP

I decided to host a subdomain with another, more reliable hosting provider. First, I purchased the hosting service and migrated all my files. Then, once I verified that everything was working as expected, the time came to point my subdomain to the new server. 

Pointing a subdomain to a new server implies modifying the subdomain's A record on the original hosting provider with the target hosting server's IP address. Time to live (TTL) varies, but most servers have a default of 14400 seconds (4 hours) and one should expect between 1 and 72 hours before the A record propagates.

I looked for a way to avoid having to manually check if the A record had propagated and was pointing to the new server. Sitting in front of my screen and refreshing my browser was too inefficient for me, so I came up with a small bash script that would ping the new server every five minutes and check if the domain was pointing to the new server's IP address.

It helped me to test the migration of a dummy subdomain, so that I could be ready for the actual TTL of the migration. In my case, it was 1 hour 44 minutes.

The interval between pings can be changed, of course. Once ping reaches the new IP address, the script ends.
