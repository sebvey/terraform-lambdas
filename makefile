test_py_lambda:
	@aws lambda invoke \
		--region=eu-west-1 \
		--function-name=$(shell terraform output -raw py_function_name) \
		local/lambda_responses/py_function_response.json

list_bucket:
	@aws s3 ls $(shell terraform output -raw lambda_bucket_name)
