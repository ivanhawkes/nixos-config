#!/bin/bash
set -e

echo "Starting Home Backup Process..."

rclone bisync "/data/home/ivan/OneDrive" "OneDrive:/" \
    --verbose \
    --copy-links \
    --progress \
    --fast-list \
    --transfers 4 \
    --checkers 8 \
    --exclude "lost+found/**" \
    --exclude "Trash.1000/**" \
    --exclude "Personal Vault/**" \
    --exclude "/Immich-Backup/" \
    --exclude ".cache"

echo "Backup completed successfully!"

