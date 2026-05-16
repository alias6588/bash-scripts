#!/bin/bash

# اگر کاربر آرگومان وارد نکرد، ازش بپرس
if [ -z "$1" ]; then

  active_connections=$(nmcli -f NAME,TYPE connection show --active | awk '$1 != "NAME" {print $1}' )

  if [ -z "$active_connections" ]; then
    echo "No active connections found. Exiting."
    exit 1
  elif [ $(echo "$active_connections" | wc -l) -eq 1 ]; then
    CONNECTION=$active_connections
  elif [ $(echo "$active_connections" | wc -l) -gt 1 ]; then
    echo "Multiple active connections found:"
    echo "$active_connections" | nl -w2 -s'. '
    read -rp "Enter the number of the connection to use: " conn_number
    CONNECTION=$(echo "$active_connections" | sed -n "${conn_number}p")
    if [ -z "$CONNECTION" ]; then
      echo "Invalid selection. Exiting."
      exit 1
    fi
  fi
    
  
  
else
  CONNECTION=$1
fi

# DNS های مورد نظر
DNS_SERVERS="178.22.122.101 185.51.200.1"

echo ">>> Setting DNS servers for connection: $CONNECTION"
nmcli connection modify "$CONNECTION" ipv4.dns "$DNS_SERVERS"
nmcli connection modify "$CONNECTION" ipv4.ignore-auto-dns no

echo ">>> Restarting connection..."
nmcli connection down "$CONNECTION" && nmcli connection up "$CONNECTION"

echo ">>> Updating DDNS on Shecan..."
curl -s "https://ddns.shecan.ir/update?password=128980fbfaccfd93"

echo "✅ Done!"

