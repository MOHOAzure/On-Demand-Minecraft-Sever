#!/bin/bash

# Game Server Backup Routine

# redirect stdout/stderr to a file
LOG_LOCATION=/var/minecraft/server/1_18/scripts/logs
LOG_NAME=$(date '+%Y-%m-%d').txt
exec >>$LOG_LOCATION/$LOG_NAME 2>&1

backup(){
    echo "$(date '+%Y-%m-%d %H:%M:%S') Game Server Backup Routine"

    # go to game server dir
    cd /var/minecraft/server

    # zip for space saving
    sudo zip -r -q backup.zip 1_18

    # store backup in S3
    sudo aws s3 mv backup.zip s3://mc-server-backup-e0470/1_18/backup.zip
}

backup
