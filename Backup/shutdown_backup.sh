
#!/bin/bash

#Checks for active connections on  port 22 (ssh) and 25565 (minecraft)
#If no connections are found, the script gracefully shuts down the
#Minecraft server (saving progress) and then shuts down the Service
#This will stop the EC2 instance and save money.

# redirect stdout/stderr to a file
LOG_LOCATION=/var/minecraft/server/1_18/scripts/logs
LOG_NAME=$(date '+%Y-%m-%d').txt
exec >>$LOG_LOCATION/$LOG_NAME 2>&1

check_port_conn(){
  sshCons=$(netstat -anp | grep :22 | grep ESTABLISHED | wc -l)
  mcCons=$(netstat -anp | grep :25565 | grep ESTABLISHED | wc -l)

  echo "$(date '+%Y-%m-%d %H:%M:%S') Active SSH Connections: $sshCons"
  echo "$(date '+%Y-%m-%d %H:%M:%S') Active Minecraft Connections: $mcCons"

  is_admin_working=false
  if [ "$sshCons" != 0 ]
  then
    is_admin_working=true
    echo "$(date '+%Y-%m-%d %H:%M:%S') There are 1 or more active ssh connections"
  fi

  is_playing=false
  if [ "$mcCons" != 0 ]
  then
    is_playing=true
    echo "$(date '+%Y-%m-%d %H:%M:%S') Somebody is playing minecraft"
  fi

  if [ "$is_admin_working" == false ] && [ "$is_playing" == false ]
  then
    echo "$(date '+%Y-%m-%d %H:%M:%S') No connections, backup & shutting down server"
    sudo systemctl stop minecraft

    # zip for space saving
    sudo zip backup.zip /var/minecraft/server/1_18/*

    # store backup in S3
    sudo aws s3 mv backup.zip s3://mc-server-backup-e0470/1_18/backup.zip

    sudo shutdown
  fi
}

check_port_conn
