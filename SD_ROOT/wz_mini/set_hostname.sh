#!/bin/sh
# Get the last octet of the IP address from eth0 or wlan0
IP_LAST=$(ip -4 addr show eth0 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | awk -F. '{print $4}')
if [ -z "$IP_LAST" ]; then
  IP_LAST=$(ip -4 addr show wlan0 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | awk -F. '{print $4}')
fi
# Set hostname as Camera XX
hostname "Camera $IP_LAST"