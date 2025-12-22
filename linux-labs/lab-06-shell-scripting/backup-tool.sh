#!/bin/bash

# Automated Backup Tool
# Author: Brady Durham
# Date: December 23, 2024
# Purpose: Backup important directories with compression and timestamping

# Configuration
BACKUP_SOURCE="$HOME/devops-portfolio"
BACKUP_DEST="$HOME/backups"
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="portfolio_backup_${DATE}.tar.gz"
MAX_BACKUPS=5  # Keep only the last 5 backups

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Function to print messages
print_msg() {
    echo -e "${GREEN}[$(date +%H:%M:%S)]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Main backup process
echo "=========================================="
echo "  Automated Backup Tool"
echo "=========================================="
echo ""

# Check if source exists
if [ ! -d "$BACKUP_SOURCE" ]; then
    print_error "Source directory does not exist: $BACKUP_SOURCE"
    exit 1
fi

# Create backup destination if it doesn't exist
if [ ! -d "$BACKUP_DEST" ]; then
    print_msg "Creating backup directory: $BACKUP_DEST"
    mkdir -p "$BACKUP_DEST"
fi

# Calculate source size
SOURCE_SIZE=$(du -sh "$BACKUP_SOURCE" | awk '{print $1}')
print_msg "Source directory: $BACKUP_SOURCE ($SOURCE_SIZE)"
print_msg "Backup destination: $BACKUP_DEST"
print_msg "Backup filename: $BACKUP_NAME"
echo ""

# Create the backup
print_msg "Creating compressed backup..."
if tar -czf "$BACKUP_DEST/$BACKUP_NAME" -C "$(dirname $BACKUP_SOURCE)" "$(basename $BACKUP_SOURCE)" 2>/dev/null; then
    BACKUP_SIZE=$(du -sh "$BACKUP_DEST/$BACKUP_NAME" | awk '{print $1}')
    print_msg "Backup created successfully! Size: $BACKUP_SIZE"
else
    print_error "Backup failed!"
    exit 1
fi

# List all backups
echo ""
print_msg "Current backups in $BACKUP_DEST:"
ls -lh "$BACKUP_DEST" | grep "portfolio_backup" | awk '{printf "  %s %s %s\n", $9, $5, $6" "$7}'

# Cleanup old backups
BACKUP_COUNT=$(ls -1 "$BACKUP_DEST"/portfolio_backup_*.tar.gz 2>/dev/null | wc -l)
if [ $BACKUP_COUNT -gt $MAX_BACKUPS ]; then
    print_warning "Found $BACKUP_COUNT backups, keeping only the last $MAX_BACKUPS"
    ls -t "$BACKUP_DEST"/portfolio_backup_*.tar.gz | tail -n +$((MAX_BACKUPS + 1)) | xargs rm -f
    print_msg "Old backups cleaned up"
fi

# Summary
echo ""
echo "=========================================="
echo "  Backup Complete!"
echo "=========================================="
echo "Location: $BACKUP_DEST/$BACKUP_NAME"
echo "Status: SUCCESS"
echo ""

# Optional: Verify the backup
read -p "Do you want to verify the backup contents? (y/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_msg "Listing backup contents:"
    tar -tzf "$BACKUP_DEST/$BACKUP_NAME" | head -20
    echo "  ... (showing first 20 files)"
fi
