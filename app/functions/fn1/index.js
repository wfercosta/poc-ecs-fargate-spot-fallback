exports.handler = async function (event, context) {
  console.log("event: ", event);

  return {
    statusCode: 201,
    body: JSON.stringify({ message: "Hello world fn1" }),
  };
};
