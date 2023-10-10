resource "aws_dynamodb_table" "cog_score_table" {
  name           = "cog-score-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = "5"
  write_capacity = "5"
  hash_key       = "user_test_id"
  range_key       = "date"

  # This will be a hash of user_id+test_id
  attribute {
    name = "user_test_id"
    type = "S"
  }

  attribute {
    name = "date"
    type = "S"
  }

}

resource "aws_dynamodb_table" "user_profile_table" {
  name           = "user-profile-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = "5"
  write_capacity = "5"
  hash_key       = "user_id"

  attribute {
    name = "user_id"
    type = "S"
  }

}

resource "aws_dynamodb_table" "checklist_table" {
  name           = "checklist-table"
  billing_mode   = "PROVISIONED"
  read_capacity  = "5"
  write_capacity = "5"
  hash_key       = "user_id"

  attribute {
    name = "user_id"
    type = "S"
  }

}
