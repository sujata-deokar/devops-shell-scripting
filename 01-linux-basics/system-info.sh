#!/usr/bin/env bash

# Script Name: system-info.sh
# Created by: Sujata Deokar
# Purpose: Display Linux system information

echo "===== SYSTEM INFORMATION ====="

echo "Hostname:"
hostname

echo "Operating System:"
grep PRETTY_NAME /etc/os-release

echo "Current User:"
whoami

echo "Disk Usage:"
df -h /

echo "Memory Usage:"
free -h

echo "Uptime:"
uptime

echo "===== SCRIPT COMPLETED ====="
