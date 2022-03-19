# On-Demand-Minecraft-Sever
On-Demand Minecraft Sever established on AWS services with very low costs.

## User Requirement
* MC ver. >= 1.17
* 15 players in a world
* usally, 8 players at the same time
* can play at any time
* may want 10+ mods
* no lag, no data loss
* reduce costs at much as possible

# Context Diagram
* How players interact with system
![Cxt](https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/blob/main/Context.drawio.png)

* Details behind chatbot and services
![Bot](https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/blob/main/Bot.png)

## System Requirement
* Machine
  * ref: https://apexminecrafthosting.com/how-much-ram-do-i-need-for-my-server
* MC Server
  * static IP or an easy-to-remember DNS
  * MC ver. = 1.17 for test
  * MC ver. = 1.18 for play
  * 1 Admin for AWS services and MC server
  * 2 Operators with MC permission >= 3
* On-demand start server
  * API Call via url click
  * Chatbot on Telegram or Discord
* Auto stop server
  * No player is playing
  * Time for sleep, don't let player stay up late

## System Design
* EC2
  * Machine AWS t3.xlarge
    * vCPU: 4 cores
    * Mem: 16 GB
    * Net Bandwidth: 5 Gbps
    * EBS Bandwidth: 2,780 Mbps
    * On-Demand Price/hr: $0.1670
  * OS
    * Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type
  * Use .pem for admin connection
* IP and DNS
  * Enable EIP on the machine
  * (optional) Create a DNS by Route53, make an A record that mapping the EIP and the DNS
  * Players could link to the server by the EIP or the DNS name
* MC Server setup
  * Details: https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/blob/main/Server%20setup/Readme.md
* On-demand start server
  * API Call & Chatbots
  * Details: https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/tree/main/On-demand%20start%20server
* Auto stop server
  * No player is playing & Time to sleep
  * Details: https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/tree/main/Auto%20stop%20server
* Backup
  * Routine
  * Just before shutdown
  * EBS snapshot
  * Details: https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/tree/main/Backup

## Cost
* The server runs in 2021 December and 2022 January. The following is cost in each month.

* 2021 December
  * Total (USD): 126.11
  * Server's CPU, memory and disk are the main source of cost
  * Network fee for backup data tranmission the secondary source of cost
  * Cost of chatbot is almost 0 due to chatbot is deployed to AWS Lambda as an event-trigger service
  * Details: https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/blob/main/Cost/202112.md

    | Cost Type                     | Sub Total (USD) | %       |
    | ----------------------------- | --------------- | ------- |
    | Server (CPU+MEM+Disk)         | 91.08           | 71.83%  |
    | DNS                           | 0.5             | 0.40%   |
    | Backup (storage+transmission) | 33.89           | 26.87%  |
    | Monitor                       | 1.14            | 0.90%   |
    | TOTAL                         | 126.11          | 100.00% |

    ![Cost-202112](https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/blob/main/Cost/Monthly%20Report%20-%20202112.png)

* 2022 January
  * Total (USD): 20.95
  * Server's CPU, memory and disk are the main source of cost
  * Cost of chatbot is almost 0
  * Backup fee is reduced because the simplified backup mechanism (no more cross-region backup)
  * After a month, the number of players and the time of play are both reduced
  * Details: https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/blob/main/Cost/202201.md
  
    | Cost Type                     | Sub Total (USD) | %       |
    | ----------------------------- | --------------- | ------- |
    | Server (CPU+MEM+Disk)         | 13.78           | 65.78%  |
    | DNS                           | 0.5             | 2.39%   |
    | Backup (storage+transmission) | 5.2             | 24.82%  |
    | Monitor                       | 1.47            | 7.02%   |
    | TOTAL                         | 20.95           | 100.00% |

    ![Cost-202112](https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/blob/main/Cost/Monthly%20Report%20-%20202201.png)
