resource "aws_placement_group" "asg-placement-group" {
  name     = "asg-placement-group"
  strategy = "cluster"
}

resource "aws_autoscaling_group" "asg-group" {
  name                      = "asg-group"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  placement_group           = aws_placement_group.asg-placement-group.id
  launch_configuration      = aws_launch_configuration.foobar.name
  vpc_zone_identifier       = [var.private_app_subnet_az1_id, private_app_subnet_az2_id.id]

  initial_lifecycle_hook {
    name                 = "Life-cycle-hook"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 2000
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

    notification_metadata = <<EOF
{
  "foo": "bar"
}
EOF

    notification_target_arn = "arn:aws:sqs:us-east-1:444455556666:queue1*"
    role_arn                = "arn:aws:iam::123456789012:role/S3Access"
  }

  tag {
    key                 = "foo"
    value               = "bar"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }

  tag {
    key                 = "lorem"
    value               = "ipsum"
    propagate_at_launch = false
  }
}

# Create a launch configuration
resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "terraform-lc-example-"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  lifecycle {
    create_before_destroy = true
  }
}

