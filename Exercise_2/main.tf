provider "aws" {
  region          = var.aws_region
}


resource "aws_lambda_function" "test_lambda" {
  filename         = "lambda.zip"
  function_name    = "greet_lambda"
  role             = "${aws_iam_role.iam_for_lambda_tf.arn}"
  handler          = "greet_lambda.lambda_handler"
  runtime          = "python3.7"
}

resource "aws_iam_role" "iam_for_lambda_tf" {
  name = "iam_for_lambda_tf"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/lambda/udacity_greeting"
  retention_in_days = 14
}

# See also the following AWS managed policy: AWSLambdaBasicExecutionRole
resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:aws:logs:*:*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda_tf.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}

data "aws_lambda_invocation" "udacity_greeting" {
  function_name = aws_lambda_function.test_lambda.function_name

  input = <<JSON
{
  "key1": "value1",
  "key2": "value2"
}
JSON
}

