
#!/usr/bin/env bash

# Script Name: backup.sh
# Created by: Sujata Deokar
# Purpose: Create a compressed backup of a directory

set -Eeuo pipefail

echo "=================================="
echo "   DIRECTORY BACKUP SCRIPT"
echo "   Created by: Sujata Deokar"
echo "=================================="

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

SOURCE_DIR="$1"

if [[ ! -d "$SOURCE_DIR" ]]; then
    echo "Error: Directory does not exist: $SOURCE_DIR"
    exit 1
fi

BACKUP_DIR="$HOME/script-backups"
mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
ARCHIVE="$BACKUP_DIR/backup_$TIMESTAMP.tar.gz"

tar -czf "$ARCHIVE" -C "$(dirname "$SOURCE_DIR")" \
    "$(basename "$SOURCE_DIR")"

echo "Backup created: $ARCHIVE"
echo "Backup completed successfully!"
