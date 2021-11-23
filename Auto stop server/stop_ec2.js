const AWS = require("aws-sdk");
var ec2 = new AWS.EC2();

exports.handler = async (event) => {
  try {
    var result;
    var params = {
      InstanceIds: [process.env.INSTANCE_ID], // put your EC2 ID in env var.
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
