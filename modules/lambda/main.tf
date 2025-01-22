##################
## Lambda Function
##################
resource "aws_lambda_function" "this" {
  function_name = var.function_name
  handler       = var.handler
  runtime       = var.runtime
  role          = aws_iam_role.lambda_role.arn
  timeout       = var.timeout
  memory_size   = var.memory_size
  publish       = var.publish

  filename         = var.source_path
  source_code_hash = filebase64sha256(var.source_path)

  environment {
    variables = var.environment_variables
  }

  tags = var.tags
}

######################
## IAM Role for Lambda
######################

resource "aws_iam_role" "lambda_role" {
  name = "${var.function_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}
##################
## IAM Role Policy
##################

resource "aws_iam_role_policy" "lambda_policy" {
  role   = aws_iam_role.lambda_role.id
  policy = jsonencode(var.lambda_policy)
}
#######################
## CloudWatch Log Group
#######################

resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = var.log_retention_in_days
}
######################
## API Gateway Trigger
######################

resource "aws_lambda_permission" "api_gateway" {
  count        = var.enable_api_gateway_trigger ? 1 : 0
  statement_id = "AllowAPIGatewayInvoke"
  action       = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.arn
  principal     = "apigateway.amazonaws.com"
}

#############
## S3 Trigger
#############

resource "aws_lambda_permission" "s3" {
  count = var.enable_s3_trigger ? 1 : 0

  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.arn
  principal     = "s3.amazonaws.com"
  source_arn    = var.s3_bucket_arn
}

##################
## S3 Notification
##################

resource "aws_s3_bucket_notification" "this" {
  count = var.enable_s3_trigger ? 1 : 0

  bucket = var.s3_bucket_name

  lambda_function {
    lambda_function_arn = aws_lambda_function.this.arn
    events              = var.s3_events
    filter_prefix       = var.s3_filter_prefix
    filter_suffix       = var.s3_filter_suffix
  }
}

###################
## DynamoDB Trigger
###################

resource "aws_lambda_permission" "dynamodb" {
  count = var.enable_dynamodb_trigger ? 1 : 0

  statement_id  = "AllowDynamoDBInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.arn
  principal     = "dynamodb.amazonaws.com"
  source_arn    = var.dynamodb_table_arn
}

#######################
## Event Source Mapping
#######################

resource "aws_event_source_mapping" "dynamodb" {
  count = var.enable_dynamodb_trigger ? 1 : 0

  event_source_arn = var.dynamodb_stream_arn
  function_name    = aws_lambda_function.this.arn
  starting_position = var.dynamodb_starting_position
  batch_size        = var.dynamodb_batch_size
}
