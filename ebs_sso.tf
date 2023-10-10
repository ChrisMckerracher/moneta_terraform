resource "aws_elastic_beanstalk_application" "cogscoretest" {
  name = "cogscoretest"
}

resource "aws_elastic_beanstalk_environment" "cogscoretest" {
  name = "cogscore-test"
  application = "cogscoretest"
  solution_stack_name = "64bit Amazon Linux 2023 v4.0.3 running Python 3.11"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

}

data "aws_iam_policy_document" "assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "aws-elasticbeanstalk-ec2-role" {
  name = "aws-elasticbeanstalk-ec2-role"
  assume_role_policy = "${data.aws_iam_policy_document.assume-role-policy.json}"
}

resource "aws_iam_policy" "read_secrets" {
  name = "read_secrets_policy"

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = "secretsmanager:GetSecretValue"
        Effect    = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sto-readonly-role-policy-attach" {
  role       = aws_iam_role.aws-elasticbeanstalk-ec2-role.name
  policy_arn = aws_iam_policy.read_secrets.arn
}

