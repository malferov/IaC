# export AWS_ACCESS_KEY_ID=your_access_key_id
# export AWS_SECRET_ACCESS_KEY=your_secret_access_key
# export AWS_REGION=eu-west-1

ec2_instance { 'name-of-instance':
  ensure            => running,
  region            => 'us-east-1',
  availability_zone => 'us-east-1a',
  image_id          => 'ami-123456', # you need to select your own AMI
  instance_type     => 't2.micro',
  key_name          => 'name-of-existing-key',
  subnet            => 'name-of-subnet',
  security_groups   => ['name-of-security-group'],
  tags              => {
    tag_name => 'value',
  },
}
