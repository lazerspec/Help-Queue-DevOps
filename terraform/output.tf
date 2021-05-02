output "vm_public_ip_jenkins" {
    value = aws_instance.jenkins-instance.public_ip
}

output "vm_public_ip_database" {
    value = aws_db_instance.mysql-database.endpoint
}

output "database_password" {
    value = "${var.db-password}"
}

output "database_username" {
    value = aws_db_instance.mysql-database.username
}