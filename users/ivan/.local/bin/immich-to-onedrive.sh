#!/bin/bash
set -e

# ==================== CONFIGURATION ====================
# Path to your Immich data folder (where your .env and docker-compose.yml live)
IMMICH_DIR="/containers/immich"

# Your Immich data upload location (defined in your .env file)
UPLOAD_LOCATION="/data/immich/library"

# Name of your rclone remote and target folder on OneDrive
ONEDRIVE_REMOTE="OneDrive:Immich-Backup"

# Database variables (Defaults match the standard Immich compose file)
DB_CONTAINER="immich_postgres"
DB_NAME="immich"
DB_USER="postgres"
# =======================================================

echo "Starting Immich Backup Process..."

# 1. Ensure a fresh database backup folder exists inside your upload location
#mkdir -p "$UPLOAD_LOCATION/database-backup"

# 2. Trigger a safe, consistent database dump via the Postgres container
#echo "Dumping database..."
#docker exec -t "$DB_CONTAINER" pg_dump --clean --if-exists --dbname="$DB_NAME" --username="$DB_USER" | gzip > "$UPLOAD_LOCATION/database-backup/immich-database.sql.gz"

# 3. Use rclone to efficiently sync the entire media and database stack to OneDrive
echo "Uploading files to OneDrive..."
rclone sync "$UPLOAD_LOCATION" "$ONEDRIVE_REMOTE" \
    --fast-list \
    --transfers 4 \
    --checkers 8 \
    --exclude "lost+found/**" \
    --verbose

echo "Backup completed successfully!"

