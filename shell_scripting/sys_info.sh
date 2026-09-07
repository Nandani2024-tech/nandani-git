#!/bin/bash

# Variables to store system information
CURRENT_DATE=$(date)
HOST_NAME=$(hostname)
USER_NAME=$(whoami)

echo "==================================="
echo "     System Information Script     "
echo "==================================="
echo "Current Date : $CURRENT_DATE"
echo "Hostname     : $HOST_NAME"
echo "Username     : $USER_NAME"
echo "==================================="
echo ""

echo "--- Disk Usage ---"
df -h
echo ""

# Taking user input
read -p "Enter a name for the new directory: " DIR_NAME
read -p "Enter a name for the output file: " FILE_NAME

echo ""
echo "Creating directory: $DIR_NAME..."
mkdir -p "$DIR_NAME"

echo "Creating file: $DIR_NAME/$FILE_NAME..."
touch "$DIR_NAME/$FILE_NAME"

echo "Fetching running processes and storing them in $DIR_NAME/$FILE_NAME..."
# Store running processes information in the file using output redirection
ps aux > "$DIR_NAME/$FILE_NAME"

echo "Script completed successfully! Check the contents of $DIR_NAME/$FILE_NAME to see the running processes."
