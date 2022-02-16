# -*- coding: utf-8 -*-

import boto3
import json
import TGHelper
import my_config

def lambda_handler(event, context):
    # print(event)
    alarm_content = event["Records"][0]["Sns"]["Message"]
    alarm_content = json.loads(alarm_content)
    
    alarmd_description = alarm_content["AlarmDescription"] # abstract
    alarmd_reason = alarm_content["NewStateReason"] # engineer oriented abstract
    # region = alarm_content["Region"]
    # alarm_trigger = alarm_content["Trigger"] # details here
    # alarm_metric = alarm_trigger["MetricName"]
    # alarm_threshold = alarm_trigger["Threshold"]
    
    # exam ec2 state
    ec2=boto3.client('ec2')
    response=ec2.describe_instances(
        InstanceIds=[
            my_config.INSTANCE_ID
        ]
    )
    instance_state = response['Reservations'][0]['Instances'][0]['State']['Name']
    if instance_state == 'pending':
        return {
            'statusCode': 200,
            'body': json.dumps('Server just started. Watcher in Rest')
        }
        
    
    # let a helper deals with interaction with Discord
    tgh = TGHelper.TGHelper()
    
    msg = "{Description}\n\n{Reason}".format(Description=alarmd_description, Reason=alarmd_reason)
    tgh.send_message(msg)
    
    return {
        'statusCode': 200,
        'body': json.dumps('Server Watcher in Rest')
    }
