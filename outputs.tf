output "lambda_bucket_name" {
    description = "S3 Bucket Name used to store lambda functions code"

    value       = aws_s3_bucket.lambda_bucket.id
}

output "py_function_name" {
    description = "Name of the py Lambda Function"
    value       = aws_lambda_function.hello_py_lambda.function_name
}
