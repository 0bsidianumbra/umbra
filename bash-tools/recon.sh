#!/usr/bin/env bash

domainName=$1

# Validate input
if [ -z "$domainName" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

if [ ! -d "output" ]; then
mkdir output
fi
timestamp=$(date +"%Y-%m-%d_%H-%M")
output_dir="./output/${domainName}-${timestamp}"
mkdir -p "$output_dir"

whoami > "$output_dir/iam.txt"
echo "----------------------------------------"
echo "[*] Running dig on $domainName"
dig $domainName > "$output_dir/dig.txt"
echo "[+] Output saved to $output_dir/dig.txt"
echo "----------------------------------------"
echo "[*] Running host on $domainName"
host $domainName > "$output_dir/host.txt"
echo "[+] Output saved to $output_dir/host.txt"
echo "----------------------------------------"
echo "[*] Running nslookup on $domainName"
nslookup $domainName > "$output_dir/nslookup.txt"
echo "[+] Output saved to $output_dir/nslookup.txt"
echo "----------------------------------------"
echo "[✓] Recon complete. All outputs saved in: $output_dir"
