#!/bin/bash
now=$(date +%d%m%Y-%H:%M:%S)
filename=$1
backupfilename=$1-$now
mysqldump  database-name > ~/backup/backup$backupfilename.sql
zip -r ~/backup/backup$backupfilename.zip ~/backup/backupadelphi$backupfilename.sql
rm ~/backup/backupi$backupfilename.sql
echo "Hi, Your database  prod backup for date $backupfilename is ready" | mutt -a ~/backup/backup$backupfilename.zip -s "Database Backup - $backupfilename" -- address-email
