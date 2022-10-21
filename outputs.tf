output "lambda_function_name" {
  description = "lambda name"
  value       = aws_lambda_function.this.function_name
}
output "lambda_function_arn" {
  description = "lambda ARN"
  value       = aws_lambda_function.this.arn
}
