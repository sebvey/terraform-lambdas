## LAMBDAS AND CLOUDWATCH LOG GROUPS

# By convention, Lambda stores logs in a group named /aws/lambda/<Function Name>
# This log group is automatically created by aws when lambda created
# It needs to be created by terraform the same time the lambda is created
# If not, an error 'already exists' occurs (has to be deleted in aws)

// Python Lambda

resource "aws_lambda_function" "hello_py_lambda" {
    function_name = "hello-terraform-lambdas-py"

    s3_bucket   = aws_s3_bucket.lambda_bucket.id
    s3_key      = aws_s3_object.hello_py_package.key

    runtime = "python3.8"
    handler = "hello.lambda_handler"

    source_code_hash = data.archive_file.hello_py_package.output_base64sha256

    role = aws_iam_role.lambda_role.arn
}

resource "aws_cloudwatch_log_group" "hello_py_log_group" {
    name = "/aws/lambda/hello-terraform-lambdas-py"

    retention_in_days = 30
}
