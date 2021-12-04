# Server Backup
* Zip all server data and store it on S3, which is located in a region other than original one
* Download zipped server data from S3 and unzip it

## Backup
* [roution](https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/blob/main/Backup/backup.sh)
* [just before shutdown](https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/blob/main/Backup/shutdown_backup.sh)
* Send to S3
  * optional: turn on versioning
```
aws s3 cp zip file} s3://{BUCKET_NAME}/{PREFIX}/{KEY:zip name}
```

## cron job
```
0 */1 * * * /var/minecraft/server/1_18/scripts/shutdown_backup.sh
0 */1 * * * /var/minecraft/server/1_18/scripts/backup.sh
```

## Restore
* Zipped server data is recorded on S3 bucket
* Download zipped server data from S3
```
aws s3 cp s3://{BUCKET_NAME}/{PREFIX}/{KEY:zip file} ./ --region={REGION_STORE_ZIP}
# --region must be added in aws CLI to avoid IllegalLocationConstraintException
```

* Unzip server data
```
unzip {zip file}
```
