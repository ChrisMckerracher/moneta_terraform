resource "aws_db_instance" "cogscoresql" {
  identifier = "cogscoresql"
  instance_class = "db.t3.micro"
  max_allocated_storage = 1000
  monitoring_interval = 0
  copy_tags_to_snapshot = true
}