locals {
  function_code = <<EOT
    exports.handler = async function(event) {
      console.log("Devon Seacrest");
      return {
        statusCode: 200,
        body: JSON.stringify({ message: "Devon Seacrest" })
      };
    };
  EOT
}

resource "aws_lambda_function" "example_lambda" {
  function_name = "devon_seacrest"
  handler      = "index.handler"
  runtime      = "nodejs14.x"
  role         = aws_iam_role.lambda_exec.arn

  environment {
    variables = {
      PROJECT_NAME = "Devon Seacrest"
    }
  }

  # Use the local function code
  source_code_hash = base64sha256(local.function_code)
  filename = "index.js"
}

