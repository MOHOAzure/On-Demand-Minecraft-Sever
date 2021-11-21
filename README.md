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
* Machine AWS t3.xlarge
  * vCPU: 4 
  * Mem: 16 GB
  * Net Bandwidth: 5 Gbps
  * EBS Bandwidth: 2,780 Mbps
  * On-Demand Price/hr: $0.1670
* MC Server setup
  * Details: https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/blob/main/Server%20setup/Readme.md
* On-demand start server
  * API Call & Chatbots
  * Details: https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/tree/main/On-demand%20start%20server
* Auto stop server
  * No player is playing
  * Details: https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/tree/main/Auto%20stop%20server
