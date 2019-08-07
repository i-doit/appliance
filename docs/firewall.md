# Firewall

The virtual appliance comes with a pre-installed host-based firewall called [ufw (uncomplicated firewall)](https://wiki.debian.org/Uncomplicated%20Firewall%20%28ufw%29). It's a command-line frontend for iptables/netfilter and easy to use.

The firewall is enabled by default. Check its status with:

~~~ {.bash}
ufw status verbose
~~~

This should give you the following output:

~~~
Status: active
Logging: on (low)
Default: deny (incoming), allow (outgoing), deny (routed)
New profiles: skip

To                         Action      From
--                         ------      ----
22/tcp                     ALLOW IN    Anywhere                  
80/tcp                     ALLOW IN    Anywhere                  
443/tcp                    ALLOW IN    Anywhere                  
22/tcp (v6)                ALLOW IN    Anywhere (v6)             
80/tcp (v6)                ALLOW IN    Anywhere (v6)             
443/tcp (v6)               ALLOW IN    Anywhere (v6)
~~~

As you can see outgoing traffic is completely allowed but incoming traffic is completely filtered except ports for SSH (22) and HTTP(S) (80/443). This is valid for both IPv4 and IPv6.
