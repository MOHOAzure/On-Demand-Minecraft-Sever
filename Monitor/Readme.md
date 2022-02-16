# Server Performance Monitor

## Use Case
* Alert when CPU usage of the server is too high
  * Alert is sent to telegram channel for players via a chatbot built on Lambda

## Tech
* Monitor server CPU with Cloudwatch
  * CPUUtilization
  * Average
* Use a SNS as communication channel to send alert to Lambda
  * Name: SERVER_CPU_HIGH
  * Type: Standard
  * Policy: Default
  * Subscription: The Lambda
* Lambda
  * Send alerts to telegram
  * How to setup telegram chatbot: https://github.com/MOHOAzure/Telegram-chat-bot-

### Lambda
#### Code
* Python 3.8
* Dependency: telebot
* Details: https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/tree/performance/Monitor/Lambda/tg-bot-server-watcher
#### Environment variables
* INSTANCE_ID
  * Instance under watch
* TELEGRAM_TOKEN
  * TG bot token
* CHAT_ID_DM
  * Id of direct message channel with bot. This is used for dev
* CHAT_ID_GROUP_MAIN
  * Id of main group full of users
* CHAT_ID_GROUP_TEST
  * Id of test group. Add bot to here, before it formally join the group full of users
