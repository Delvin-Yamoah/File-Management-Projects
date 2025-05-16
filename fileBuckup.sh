#!/bin/bash

# Ask for the source folder to back up
echo "Enter the source folder you want to back up (e.g., /home/user/Downloads):"
read SOURCE

# Ask for the destination folder where you want to store the backup
echo "Enter the destination folder (e.g., /home/user/Backups):"
read DEST

# Ask if you want to compress the backup into a .tar.gz file
echo "Do you want to compress the backup? (yes/no)"
read COMPRESS

# Ask if you want a full or partial backup
echo "Do you want a full backup (all files) or partial (some specific files)? (full/partial)"
read BACKUP_TYPE

# If partial backup, ask which files/folders to back up
if [ "$BACKUP_TYPE" == "partial" ]; then
  echo "Enter the list of files/folders to back up, separated by commas (e.g., file1.txt, folder1):"
  read PARTIAL_LIST
fi

# Get the current date and time for the backup name
DATE=$(date +%Y%m%d%H%M%S)
BACKUP_NAME="backup_$DATE"

# Start the backup
echo "Starting the backup..."

if [ "$BACKUP_TYPE" == "full" ]; then
  # Full backup: Copy everything from source to destination
  cp -r "$SOURCE" "$DEST/$BACKUP_NAME"
elif [ "$BACKUP_TYPE" == "partial" ]; then
  # Partial backup: Copy only the specified files/folders
  IFS=',' read -r -a FILES <<< "$PARTIAL_LIST"
  mkdir "$DEST/$BACKUP_NAME"
  for file in "${FILES[@]}"; do
    cp -r "$SOURCE/$file" "$DEST/$BACKUP_NAME/"
  done
fi

# Compress the backup if requested
if [ "$COMPRESS" == "yes" ]; then
  tar -czf "$DEST/$BACKUP_NAME.tar.gz" -C "$DEST" "$BACKUP_NAME"
  rm -rf "$DEST/$BACKUP_NAME"  # Remove uncompressed folder after compression
  echo "Backup compressed into $DEST/$BACKUP_NAME.tar.gz"
else
  echo "Backup stored at $DEST/$BACKUP_NAME"
fi

# Ask if you want to schedule future backups
echo "Do you want to schedule this backup to run automatically (daily)? (yes/no)"
read SCHEDULE

if [ "$SCHEDULE" == "yes" ]; then
  # Add the backup to cron to run every day at midnight
  echo "Scheduling the backup..."
  (crontab -l ; echo "0 0 * * * /path/to/backup.sh") | crontab -
  echo "Backup scheduled to run daily at midnight."
fi
