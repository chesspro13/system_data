#!/bin/bash

hostname=$HOSTNAME
# ipaddress=$(ip addr | grep "eno" | grep -oP 'inet\s\K(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})')
ipaddress=$(hostname -I | awk '{print $1}')
os=$(lsb_release -ad 2>/dev/null | grep -i description | cut -s -f2)
drives=$(lsblk -o NAME,SIZE,TYPE | grep disk)
driveList=$(echo ${drives//disk/} | tr -d '\n')


mem=$(grep MemTotal /proc/meminfo)
ramKB=${mem//MemTotal:/}
ramTotal=${ramKB//kB/}
kb=$(echo $ramTotal | tr -d ' ')
ram="$(($kb/(1024*1024)))GB"

echo "Hostname: $hostname"
echo "OS: $os" 
echo "IP Address: $ipaddress"
echo "Drives: $driveList"
echo "Ram: $ram"

echo "Mermaid Notation:"
echo "$hostname[$hostname<br/>IP: $ipaddress<br/>OS: $os<br>Software: N/A<br/>HHD: $driveList<br/>Memory: $ram]:::device"
