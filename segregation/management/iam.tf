
resource "aws_iam_group" "env_group" {
  name = "environments"
  path = "/users/"
}

resource "aws_iam_user" "env_user" {
  count = "${length(var.account)}"
  name  = "${element(keys(var.account), count.index)}_user"
  path  = "/system/"
}

resource "aws_iam_group_membership" "env_member" {
  name = "environment_member"
  users = ["${aws_iam_user.env_user.*.name}"]
  group = "${aws_iam_group.env_group.name}"
}

resource "aws_iam_group_policy" "env_policy" {
  name   = "environment_policy"
  group  = "${aws_iam_group.env_group.id}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:Describe*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
