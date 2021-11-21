# On-demand start server

## API call
* Lambda + API gateway

### Lambda
* Node.js 14
* Permission
  * lambda basic
  * describeInstances
  * startInstances
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
    
    if (instance.State.Name == "stopped") {
      var cmd = await ec2.startInstances(params).promise();
      result = "Starting server, please wait for 1 min";
    } else if (instance.State.Name == "running") {
      result = "Server is running, just jump in!";
    } else {
      result = "Server is changing status, please try again";
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
      body: "Error starting server",
    };
    return response;
  }
};
```

### API gateway
* Add this trigger to the lambda
* Protocol: HTTP
* Security: open
* Record the URL of the API gateway

## Chatbot on Discord

## Chatbot on TG
