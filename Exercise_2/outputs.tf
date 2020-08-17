# TODO: Define the output variable for the lambda function.
output "result_entry" {
  value = jsondecode(data.aws_lambda_invocation.udacity_greeting.result)
}