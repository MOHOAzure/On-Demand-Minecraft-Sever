#!/bin/bash

#Checks for active connections on  port 22 (ssh) and 25565 (minecraft)
#If no connections are found, the script gracefully shuts down the
#Minecraft server (saving progress) and then shuts down the Service
#This will stop the EC2 instance and save money.

# redirect stdout/stderr to a file
LOG_LOCATION=./logs
LOG_NAME=$(date '+%Y-%m-%d').txt
exec >>$LOG_LOCATION/"$LOG_NAME" 2>&1

check_port_conn(){
  sshCons=$(netstat -anp | grep :22 | grep ESTABLISHED | wc -l)
  mcCons=$(netstat -anp | grep :25565 | grep ESTABLISHED | wc -l)

  echo "$(date '+%Y-%m-%d %H:%M:%S') Active SSH Connections: $sshCons"
  echo "$(date '+%Y-%m-%d %H:%M:%S') Active Minecraft Connections: $mcCons"

  if [[ $((sshCons)) != 0 ]]
  then
    echo "$(date '+%Y-%m-%d %H:%M:%S') There are 1 or more active ssh connections, skip termination"
    return 0
  fi
  if [ $((mcCons)) != 0 ]
  then
    echo "$(date '+%Y-%m-%d %H:%M:%S') Somebody is playing minecraft, skip termination"
    return 0
  fi

  echo "$(date '+%Y-%m-%d %H:%M:%S') No ssh connections, shutting down server"
  sudo systemctl stop minecraft
  sudo shutdown
}

check_port_conn
