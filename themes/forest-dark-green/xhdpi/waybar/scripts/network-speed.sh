#!/usr/bin/env bash

# Priorität: Ethernet > WLAN
iface=$(ip route get 1 | awk '{for(i=1;i<=NF;i++){if($i=="dev"){print $(i+1)}}}')

if [[ -z "$iface" || ! -d /sys/class/net/$iface ]]; then
    echo "Disconnected ⚠"
    exit 0
fi

rx1=$(cat /sys/class/net/$iface/statistics/rx_bytes)
tx1=$(cat /sys/class/net/$iface/statistics/tx_bytes)
sleep 1
rx2=$(cat /sys/class/net/$iface/statistics/rx_bytes)
tx2=$(cat /sys/class/net/$iface/statistics/tx_bytes)

rx=$(( (rx2 - rx1)/1024 ))  # kB/s
tx=$(( (tx2 - tx1)/1024 ))  # kB/s

# Für WLAN: SSID ermitteln
if [[ "$iface" == w* ]]; then
    essid=$(iwgetid -r)
    echo "↓${rx} kB/s ↑${tx} kB/s"
else
    ip=$(ip -4 addr show $iface | grep -oP '(?<=inet\s)\d+(\.\d+){3}')
    echo "  ${rx} kB/s  ${tx} kB/s "
fi
