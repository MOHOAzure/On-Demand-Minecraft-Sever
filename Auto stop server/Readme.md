# Auto stop server

# Table of Contents
1. [No player is playing](#no-player-is-playing)
   1. [Server port activities](#server-port-activities)
   2. [CloudWatch Alarm](#cloudwatch-alarm)
3. [Time to sleep](#time-to-sleep)

## No player is playing

### Server port activities
* Monitor server ports (ssh, game port)
* If there is none reaches server via the ports, then the server and the machine would be stopped.
* [shell script](https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/blob/main/Auto%20stop%20server/shutdown.sh)

### CloudWatch Alarm
* Monitor the number of network package into the machine (not a reliable method since it's no easy to identify 'no play')
* Metric: NetworkIn
* Statistic: Max
* Threshold type: static
* Datapoint & Period: 2 of 2 min
* Whenever: Lower than 500
* In Alarm, trigger EC2 stop

## Time to sleep
* Lambda + CloudWatch Event

### Lambda
* Node.js 14
* Permission
  * Lambda basic
  * describeInstances
  * stopInstances
* Environment variables
  * INSTANCE_ID
* [Code](https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/blob/main/Auto%20stop%20server/stop_ec2.js)

### CloudWatch Event
* stop server at 04:00 A.M., Taipei time
* Schedule: cron(0 20 ? * * *)
