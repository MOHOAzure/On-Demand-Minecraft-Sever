# Server Backup
* Zip all server data and store it on S3, which is located in a region other than original one
* Download zipped server data from S3 and unzip it

## Prerequisite
* A cron job is ready to automatically shutdown server
* [The script](https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/blob/main/Auto%20stop%20server/shutdown.sh)

## Backup
* [backup script in shutdown.sh](https://github.com/MOHOAzure/On-Demand-Minecraft-Sever/blob/main/Backup/shutdown_backup.sh)
* Send to S3
```
aws s3 cp zip file} s3://{BUCKET_NAME}/{PREFIX}/{KEY:zip name}
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
