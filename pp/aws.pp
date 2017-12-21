# export AWS_ACCESS_KEY_ID=your_access_key_id
# export AWS_SECRET_ACCESS_KEY=your_secret_access_key
# export AWS_REGION=eu-west-1
# or ~/.aws/credentials
#[default]
#aws_access_key_id = id
#aws_secret_access_key = key

ec2_securitygroup { 'pp-sg-www':
  ensure      => present,
#  ensure      => absent,
  region      => 'us-west-2',
#  vpc         => 'name-of-vpc',
  description => 'a description of the group',
  ingress     => [{
    protocol  => 'tcp',
    port      => 22,
    cidr      => '0.0.0.0/0',
  },
  {
    protocol  => 'tcp',
    port      => 80,
    cidr      => '0.0.0.0/0',
  }],
  tags        => {
    tag_name  => 'value',
  },
}

ec2_instance { 'pp-instance':
  ensure            => running,
#  ensure            => absent,
  region            => 'us-west-2',
#  availability_zone => 'us-west-2a',
  image_id          => 'ami-bf4193c7',
  instance_type     => 't2.micro',
#  key_name          => 'name-of-existing-key',
  subnet            => 'subnet-us-west-2a',
  security_groups   => ['pp-sg-www'],
  tags              => {
    tag_name => 'terraform',
  },
  require => [
    Ec2_securitygroup['pp-sg-www'],
  ]
}
