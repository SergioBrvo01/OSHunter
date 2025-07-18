#!/bin/bash

function show_banner() {
  clear
  echo -e "\e[1;36m"
  cat << "EOF"
 _____ _____ _   _             _            
|  _  /  ___| | | |           | |           
| | | \ `--.| |_| |_   _ _ __ | |_ ___ _ __ 
| | | |`--. \  _  | | | | '_ \| __/ _ \ '__|
\ \_/ /\__/ / | | | |_| | | | | ||  __/ |   
 \___/\____/\_| |_/\__,_|_| |_|\__\___|_|   
EOF
  echo -e "\e[0m"
  echo -e "\e[1;33mOSHunter v1.0 - AutoDetect Operative System\e[0m"
  echo -e "\e[34m---------------------------------------------\e[0m"
  echo -e "by sergiobrvo01"
}

function ctrl_c() {
    echo -e "\n\n\e[1;31m[!] Exiting...\e[0m"
    exit 1
}

trap ctrl_c INT

function check_os() {
    while true; do
        echo -e "\n"
        read -p "IP Address (or 'q' to quit): " ip
        [[ "$ip" == "q" ]] && exit 0
        
        # IP Validation
        if [[ -z "$ip" ]]; then
            echo -e "\e[1;31m\n[!] Error: IP Address cannot be empty\e[0m"
            continue
        elif [[ ! $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
            echo -e "\e[1;31m\n[!] Error: Invalid IP format\e[0m"
            continue
        fi
        
        echo -e "\nDetecting OS for $ip..."
        
        # Ping Result
        ping_result=$(ping -c 2 "$ip" 2>&1)
        
        # Host reachable?
        if [[ $? -ne 0 ]]; then
            echo -e "\e[1;31m[!] Error: Host unreachable or not responding\e[0m"
            continue
        fi
        
        # Extract TTL
        ttl=$(echo "$ping_result" | grep -o 'ttl=[0-9]*' | head -n1 | cut -d= -f2)
        
        if [[ -z "$ttl" ]]; then
            echo -e "\e[1;31m[!] Error: Could not determine TTL\e[0m"
            continue
        fi
        
        echo -e "\n\e[1;35m[*] Detected TTL: $ttl\e[0m"
        
        # OS
        if (( ttl <= 64 )); then
            echo -e "\e[1;32m[+] Target OS: Linux or macOS\e[0m"
            echo -e "\e[1;32m[!] Most machines are Linux, remember that.\e[0m"
            exit 0
        elif (( ttl <= 128 )); then
            echo -e "\e[1;32m[+] Target OS: Windows\e[0m"
            exit 0
        elif (( ttl <= 255 )); then
            echo -e "\e[1;32m[+] Target: Network Devices\e[0m"
            exit 0
        else
            echo -e "\e[1;33m[!] Unknown OS (TTL out of common range)\e[0m"
            exit 1
        fi
    done
}

show_banner
check_os

