variable "account" {}

resource "aws_iam_policy" "env_policy" {
  name   = "environment_policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role" "env_role" {
  name = "environment_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "AWS": "arn:aws:iam::${var.account}:root"
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "env_attach" {
  role       = "${aws_iam_role.env_role.name}"
  policy_arn = "${aws_iam_policy.env_policy.arn}"
}
