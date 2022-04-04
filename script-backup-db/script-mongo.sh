
#!/bin/bash
 
######################################################################
##
##   MongoDB Database Backup Script 
##   Written By: Rahul Kumar
##   URL: https://tecadmin.net/shell-script-backup-mongodb-database/
##   Update on: June 20, 2020
##
######################################################################
 
#export PATH=/bin:/usr/bin:/usr/local/bin
TODAY=`date +"%d%b%Y"`
 
######################################################################
######################################################################
 
DB_BACKUP_PATH='backup'
#MONGO_HOST='localhost'
#MONGO_PORT='27017'

# If mongodb is protected with username password.
# Set AUTH_ENABLED to 1 
# and add MONGO_USER and MONGO_PASSWD values correctly


DB_NAME='db name'
MONGO_HOST='hostname'
#MONGO_PORT='27017'
AUTH_ENABLED=0
MONGO_USER='username'
MONGO_PASSWD='password'

# Set DATABASE_NAMES to "ALL" to backup all databases.
# or specify databases names seprated with space to backup 
# specific databases only.

DATABASE_NAMES='db name'
#DATABASE_NAMES='mydb db2 newdb'

## Number of days to keep local backup copy
BACKUP_RETAIN_DAYS=30   
 
######################################################################
######################################################################
 
mkdir -p ${DB_BACKUP_PATH}/${TODAY}

#AUTH_PARAM=""

#if [ ${AUTH_ENABLED} -eq 1 ]; then
#	AUTH_PARAM=" --username ${MONGO_USER} --password ${MONGO_PASSWD} "
#fi

#if [ ${DATABASE_NAMES} = "tokensmarketcap" ]; then
#	echo "You have choose to backup all databases"
 #	mongodump --forceTableScan --host ${MONGO_HOST} --port ${MONGO_PORT} ${AUTH_PARAM} --db ${DB_NAME} --out ${DB_BACKUP_PATH}/${TODAY}/
#else
	echo "Running backup for selected databases"
	for DB_NAME in ${DATABASE_NAMES}
	do
		mongodump --forceTableScan --uri mongodb+srv://${MONGO_USER}:${MONGO_PASSWD}@${MONGO_HOST}.mongodb.net/${DB_NAME}  --out ${DB_BACKUP_PATH}/${TODAY}/
	done
#fi

 
######## Remove backups older than {BACKUP_RETAIN_DAYS} days  ########
 
DBDELDATE=`date +"%d%b%Y" --date="${BACKUP_RETAIN_DAYS} days ago"`
 
if [ ! -z ${DB_BACKUP_PATH} ]; then
      cd ${DB_BACKUP_PATH}
      if [ ! -z ${DBDELDATE} ] && [ -d ${DBDELDATE} ]; then
            rm -rf ${DBDELDATE}
      fi
fi

   tar -czvf  ~/${DB_BACKUP_PATH}/${TODAY}.tar.gz  ~/${DB_BACKUP_PATH}/${TODAY}/DATABASE_NAMES
  
 

 echo "Hi, Your database backup for date backup mongodb metawoop is ready" | mutt -a ~/$DB_BACKUP_PATH/$TODAY.tar.gz  -s "Database Backup "  -- email address 
######################### End of script ############################




