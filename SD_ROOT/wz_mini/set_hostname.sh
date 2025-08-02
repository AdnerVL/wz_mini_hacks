#!/bin/sh

CONF_PATH="/mnt/mmc/wz_mini/wz_mini.conf"  # Adjust path if needed

# Get the last octet from eth0 or wlan0
LAST_OCTET=$(ip -4 addr show eth0 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | awk -F. '{print $4}')
if [ -z "$LAST_OCTET" ]; then
  LAST_OCTET=$(ip -4 addr show wlan0 2>/dev/null | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | awk -F. '{print $4}')
fi

# Only proceed if we found an octet
if [ -n "$LAST_OCTET" ]; then
  # Update CUSTOM_HOSTNAME= line in config
  sed -i "s/^CUSTOM_HOSTNAME=.*/CUSTOM_HOSTNAME=\"Camera $LAST_OCTET\"/" "$CONF_PATH"
fi