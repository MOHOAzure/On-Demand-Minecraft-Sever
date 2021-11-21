# Auto stop server

## No player is playing
* CloudWatch Alarm
* Monitor network going into the machine
* Metric: NetworkIn
* Statistic: Max
* Period: 15 min
* Threshold type: static
* Whenever: Lower than 100


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
* Code
```
const AWS = require("aws-sdk");
var ec2 = new AWS.EC2();

exports.handler = async (event) => {
  try {
    var result;
    var params = {
      InstanceIds: [process.env.INSTANCE_ID],
    };
    var data = await ec2.describeInstances(params).promise();
    var instance = data.Reservations[0].Instances[0];

    if (instance.State.Name !== "stopped") {
        var stop_data = await ec2.stopInstances(params).promise();
        result = "Stopping server...goodbye";
    } else {
      result = "Server not running";
    }
    console.info(result+" "+params.InstanceIds);
    
    const response = {
      statusCode: 200,
      body: result,
    };
    return response;
  } catch (error) {
    console.error(error);
    const response = {
      statusCode: 500,
      body: "Error during stopping server",
    };
    return response;
  }
};
```

### CloudWatch Event
* stop server at 04:00 A.M., Taipei time
* Schedule: cron(0 20 ? * * *)
