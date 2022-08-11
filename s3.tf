## S3 BUCKET

resource "random_pet" "bucket_name" {
    // 'id' generated from parameters below
    prefix = "terra-lambdas"
    length = 2
}

resource "aws_s3_bucket" "lambda_bucket" {
    bucket          = random_pet.bucket_name.id

    force_destroy   = true
}


## S3 OBJECTS

// Python Package

data "archive_file" "hello_py_package" {
    type = "zip"

    source_dir  = "${path.root}/functions/hello_py"
    output_path = "${path.root}/local/lambda_packages/hello_py_package.zip"
}

resource "aws_s3_object" "hello_py_package" {
    bucket  = aws_s3_bucket.lambda_bucket.id

    key     = "hello_py_package.zip"
    source  = data.archive_file.hello_py_package.output_path

    etag    = filemd5(data.archive_file.hello_py_package.output_path)
}
