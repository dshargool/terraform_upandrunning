output "neo_arn" {
  value = aws_iam_user.example[*].arn
  description = "ARN for user neo"
}
