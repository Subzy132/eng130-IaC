resource "aws_launch_template" "eng130_subhaan_lt_test" {
  name = "eng130_subhaan_lt_test"
  image_id = var.webapp_ami_id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = "t2.micro"
  key_name = var.aws_key_name
  monitoring {
    enabled = false
  }
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination = true
    device_index = 0
    security_groups = [aws_security_group.eng130_subhaan_sg.id]
  }
  placement {
    availability_zone = "eu-west-1"
  }
  lifecycle {
    create_before_destroy = true
  }
# vpc_security_group_ids = [aws_security_group.eng130_subhaan_sg.id]
  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "eng130_subhaan"
    }
  }

  user_data = filebase64("${path.module}/provision.sh")
}


# resource "aws_launch_template" "eng130_subhaan_lt"{
#     name = "eng130_subhaan_lt"
#     image_id = var.webapp_ami_id
#     instance_type = var.instance_type
#     key_name = var.aws_key_name
#     vpc_security_group_ids = ["${aws_security_group.eng130_subhaan_sg.id}"]
#     user_data = filebase64("${path.module}/provision.sh")
#     tags = {
#         Name = "eng130_subhaan_lt"
#     }
# }
