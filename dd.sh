#!/bin/bash

# Update and upgrade system
echo "[*] Updating and upgrading the system..."
apt update && apt upgrade -y

# Install screen
echo "[*] Installing screen..."
apt install screen -y

# Install xxx
echo "[*] Installing xxx..."
apt install hping3 -y

# Check if screen is installed
if ! command -v screen &> /dev/null; then
    echo "[!] Error: screen is not installed or not found."
    exit 1
fi

# Check if xxx is installed
if ! command -v hping3 &> /dev/null; then
    echo "[!] Error: xxx is not installed or not found."
    exit 1
fi

# Get only xxx parameters from user
read -p "Enter only xxx parameters (example: --flood -S -p 80 --rand-source 8.8.8.8): " hping_params

# Get screen session name from user
read -p "Enter a name for the screen session: " session_name

# Create new screen session
screen -dmS "$session_name"

# Build the full command
full_command="hping3 $hping_params"

# Send the command to the screen session
screen -S "$session_name" -X stuff "$full_command\n"

# Show info to user
echo "[✓] Screen session '$session_name' started and running the command:"
echo "$full_command"
echo "To attach to the screen, use:"
echo "screen -r $session_name"
