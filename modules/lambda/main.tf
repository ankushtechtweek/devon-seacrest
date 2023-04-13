
data "archive_file" "lambda_package" {
  type        = "zip"
  source_file = "${path.module}/index.js"
  output_path = "${path.module}/devon.zip"
}


resource "aws_lambda_function" "devon_lambda" {
  filename      = "${data.archive_file.lambda_package.output_path}"
  function_name = "devon_seacrest"
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  role          = aws_iam_role.lambda_exec.arn
  source_code_hash = "${data.archive_file.lambda_package.output_base64sha256}"

  environment {
    variables = {
      PROJECT_NAME = "Devon Seacrest"
    }
  }

}
