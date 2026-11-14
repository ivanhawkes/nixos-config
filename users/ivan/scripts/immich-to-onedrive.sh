#!/bin/bash
set -e

# This sync copies the media library; it does not create a database dump.
UPLOAD_LOCATION="/data/immich/library"
ONEDRIVE_REMOTE="OneDrive:Immich-Backup"

echo "Uploading files to OneDrive..."
rclone sync "$UPLOAD_LOCATION" "$ONEDRIVE_REMOTE" \
    --fast-list \
    --transfers 4 \
    --checkers 8 \
    --exclude "lost+found/**" \
    --verbose

echo "Backup completed successfully!"
