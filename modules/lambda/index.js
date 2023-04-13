exports.handler = async function(event) {
    console.log("Devon Seacrest");
    return {
      statusCode: 200,
      body: JSON.stringify({ message: "Devon Seacrest" })
    };
  };