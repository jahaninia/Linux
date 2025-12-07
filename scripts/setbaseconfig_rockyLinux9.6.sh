#!/bin/bash

# --- Helper: exit on error ---
set -e

echo "=== Rocky Linux Initial Setup Script ==="

# --- 1. Change hostname ---
read -p "Enter new hostname: " NEW_HOSTNAME
if [ -n "$NEW_HOSTNAME" ]; then
    hostnamectl set-hostname "$NEW_HOSTNAME"
    echo "Hostname changed to $NEW_HOSTNAME"
else
    echo "Hostname not changed (empty input)"
fi

# --- 2. Network configuration ---
echo
nmcli device status
echo

read -p "Enter interface name to configure (e.g., eth0, ens160): " IFACE
read -p "Use DHCP? (y/n): " DHCP

if [ "$DHCP" == "y" ]; then
    nmcli con mod "$IFACE" ipv4.method auto
    nmcli con up "$IFACE"
    echo "Network set to DHCP on $IFACE"
else
    read -p "Enter static IP (e.g., 192.168.1.10/24): " IPADDR
    read -p "Enter gateway: " GATEWAY
    read -p "Enter DNS servers comma-separated (e.g., 8.8.8.8,1.1.1.1): " DNS

    nmcli con mod "$IFACE" ipv4.addresses "$IPADDR"
    nmcli con mod "$IFACE" ipv4.gateway "$GATEWAY"
    nmcli con mod "$IFACE" ipv4.dns "$DNS"
    nmcli con mod "$IFACE" ipv4.method manual
    nmcli con up "$IFACE"

    echo "Static network config applied to $IFACE"
fi

# --- 3. Change password ---
echo
read -p "Change root password? (y/n): " CHPASS
if [ "$CHPASS" == "y" ]; then
    passwd root
else
    echo "Password not changed."
fi

# --- 4. Update system ---
echo
read -p "Run system update now? (y/n): " UPG
if [ "$UPG" == "y" ]; then
    dnf clean all
    dnf -y update
    echo "System updated."
else
    echo "Update skipped."
fi

echo
echo "=== Setup Completed ==="
