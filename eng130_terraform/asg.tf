# resource "aws_placement_group" "eng130_subhaan_pg" {
#   name     = "eng130_subhaan_pg"
#   strategy = "cluster"
# }

# resource "aws_autoscaling_group" "eng130_subhaan_asg" {
#   name                      = "eng130_subhaan_asg"
#   max_size                  = 3
#   min_size                  = 1
#   health_check_grace_period = 300
#   health_check_type         = "ELB"
#   desired_capacity          = 1
#   force_delete              = true
#   placement_group           = aws_placement_group.eng130_subhaan_pg.id
#   launch_configuration      = aws_launch_template.eng130_subhaan_lt_test.id
#   vpc_zone_identifier       = [aws_subnet.eng130_subhaan_public_subnet.id]

#   initial_lifecycle_hook {
#     name                 = "eng130"
#     default_result       = "CONTINUE"
#     heartbeat_timeout    = 2000
#     lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

#     notification_metadata = <<EOF
# {
#   "foo": "bar"
# }
# EOF

#     notification_target_arn = "arn:aws:sqs:eu-west-1a:444455556666:queue1*"
#     role_arn                = "arn:aws:iam::123456789012:role/S3Access"
#   }

#   tag {
#     key                 = "foo"
#     value               = "bar"
#     propagate_at_launch = true
#   }

#   timeouts {
#     delete = "15m"
#   }

#   tag {
#     key                 = "lorem"
#     value               = "ipsum"
#     propagate_at_launch = false
#   }
# }

resource "aws_autoscaling_group" "eng130_subhaan_asg"{
    name = "eng130_subhaan_asg"
    max_size                  = 3
    min_size                  = 1
    health_check_grace_period = 300
    health_check_type         = "ELB"
    desired_capacity          = 1
    force_delete              = true
    vpc_zone_identifier       = [aws_subnet.eng130_subhaan_public_subnet.id]

    launch_template {
      id = aws_launch_template.eng130_subhaan_lt_test.id
      version = "$Latest"
      
    }

    tag {
      key = "eng130_subhaan_asg"
      value = "eng130_subhaan_asg"
      propagate_at_launch = true
    }

}