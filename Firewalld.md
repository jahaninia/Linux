#Experiment 1 - no active zones
I run the command firewall-cmd --get-active-zones.

The result is: terminal shows nothing.

Experiment 2 - add zone=john with no rules
I run these three commands:

firewall-cmd --new-zone=john --permanent;
firewall-cmd --reload;
firewall-cmd --get-active-zones;
The result is:

The web page renders properly.

But my terminal still does not print any active zones.

Experiment 3 - add rules to zone=john
I run these three commands:

# replace 1.1.1.1 with my home's ip address
firewall-cmd --zone=john --add-source=1.1.1.1/24 --permanent;
firewall-cmd --reload;
firewall-cmd --get-active-zones;
The result is:

Port 80 gets blocked and web page now times out and is unreachable

My terminal prints:

john
  sources: 1.1.1.1/24
Experiment 4 - delete zone=john
I run these commands:

firewall-cmd --delete-zone=john --permanent;
firewall-cmd --reload;
The result is:

My web page is able to reload again.

Experiment 5 - adding interface=eth0 to zone=public
I tried activating my public zone with this command:

firewall-cmd --zone=public --permanent --add-interface=eth0;
firewall-cmd
firewall-cmd --reload;
firewall-cmd --get-active-zones;
The result is:

My webpage is still able to load.

My terminal shows:

public
  interfaces: eth0
Experiment 6 - re-adding zone=john
I run these commands:

firewall-cmd --new-zone=john --permanent;
firewall-cmd --reload;
firewall-cmd --zone=john --add-source=1.1.1.1/24 --permanent;
firewall-cmd --reload;
firewall-cmd --get-active-zones;
The result is:

Port 80 gets blocked and web page now times out and is unreachable

My terminal prints:

john
  sources: 1.1.1.1/24
public
  interfaces: eth0

Final Result
So after all these experiments, firewall-cmd --list-all-zones will show this:

block
  target: %%REJECT%%
  icmp-block-inversion: no
  interfaces:
  sources:
  services:
  ports:
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:


dmz
  target: default
  icmp-block-inversion: no
  interfaces:
  sources:
  services: ssh
  ports:
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:


drop
  target: DROP
  icmp-block-inversion: no
  interfaces:
  sources:
  services:
  ports:
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:


external
  target: default
  icmp-block-inversion: no
  interfaces:
  sources:
  services: ssh
  ports:
  protocols:
  masquerade: yes
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:


home
  target: default
  icmp-block-inversion: no
  interfaces:
  sources:
  services: dhcpv6-client mdns samba-client ssh
  ports:
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:


internal
  target: default
  icmp-block-inversion: no
  interfaces:
  sources:
  services: dhcpv6-client mdns samba-client ssh
  ports:
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:


john (active)
  target: default
  icmp-block-inversion: no
  interfaces:
  sources: 1.1.1.1/24
  services:
  ports:
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:


public (active)
  target: default
  icmp-block-inversion: no
  interfaces: eth0
  sources:
  services: dhcpv6-client ssh
  ports: 80/tcp
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:


trusted
  target: ACCEPT
  icmp-block-inversion: no
  interfaces:
  sources:
  services:
  ports:
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:


work
  target: default
  icmp-block-inversion: no
  interfaces:
  sources:
  services: dhcpv6-client ssh
  ports:
  protocols:
  masquerade: no
  forward-ports:
  source-ports:
  icmp-blocks:
  rich rules:

ADDITIONAL INFORMATION
