#!/bin/sh
# Database name
db_name=
db_host=t
db_user=
db_password=
# Backup storage directory 
backupfolder=~/postgresql/backups

# Notification email address 
recipient_email=<mail to send>

# Number of days to store the backup 
keep_day=30

sqlfile=$backupfolder/database-$(date +%d-%m-%Y_%H-%M-%S).sql
zipfile=$backupfolder/database-$(date +%d-%m-%Y_%H-%M-%S).zip

#create backup folder
mkdir -p $backupfolder

# Create a backup

if pg_dump "postgresql://$db_user:$db_password@$db_host/$db_name"  > $sqlfile ; then
   echo 'Sql dump created'
else
   echo 'pg_dump return non-zero code' | mailx -s 'No backup was created!' $recipient_email
   exit
fi

# Compress backup 
if gzip -c $sqlfile > $zipfile; then
   echo 'The backup was successfully compressed'
else
   echo 'Error compressing backup' | mailx -s 'Backup was not created!' $recipient_email
   exit
fi

rm $sqlfile
echo "Hi, Your database backup for date backup mongodb tokenmarketcap is ready" | mutt -a $zipfile -s "Database Backup - $zipfile" -- $recipient_email
#rm $sqlfile 
#echo $zipfile | mailx -s 'Backup was successfully created' $recipient_email

# Delete old backups 
find $backupfolder -mtime +$keep_day -delete

