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

resource "aws_lambda_function" "devon_lambda" {
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
  filename = "lambda_function.zip"
}

data "archive_file" "lambda_package" {
  type = "zip"
  source_file = file("./../${path.module}/index.js")
  output_path = "lambda_function.zip"
}
