#!/usr/bin/env bash
set -e

echo "Running on " `date`
echo "Backing up system packages"
/Users/dhruv/bin/system_packages.sh

echo "Backing up important directories to Dropbox"
set -x 

duplicity --include-globbing-filelist "/Users/dhruv/.backup_files" --exclude '*' / "file:///Users/dhruv/Dropbox/backups"

cp /Users/dhruv/.backup_files /Users/dhruv/Dropbox/backups/

echo "Done."
