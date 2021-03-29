output "all_users" {
  value = aws_iam_user.example
  description = "All user"
}

output "all_arns" {
  value = values(aws_iam_user.example)[*].arn
  description = "User ARNs for all users"
}

output "upper_names" {
  value = [for name in var.user_names : upper(name) if length(name) < 5 ]
  description = "Short names to upper case"
}

output "bios" {
  value = [for name, role in var.hero_thousand_faces : "${name} is the ${role}"]
  description = "Output as list"
}

output "upper_roles" {
  value = {for name, role in var.hero_thousand_faces : upper(name) => upper(role)}
  description = "Output maps"
}

output "for_directive" {
  value = <<EOF
%{ for name in var.user_names ~} 
${name}
%{ endfor ~}
EOF

description = "For using string directives with strip marker"
}
