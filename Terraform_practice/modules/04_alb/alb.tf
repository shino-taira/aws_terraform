#------------------------
# ALB
#------------------------
resource "aws_lb" "main_alb" {
  name               = "terraform-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.sg_ec2]
  subnets            = [var.pub_subnets_1a, var.pub_subnets_1c]
  tags = {
    Name = "terraform-alb"
  }
}

resource "aws_lb_target_group" "main_target_group" {
  name     = "terraform-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    path                = "/"
    port                = 80
    timeout             = 5
    unhealthy_threshold = 2
    matcher             = 200
  }
}

resource "aws_lb_target_group_attachment" "alb_attachment" {
  target_group_arn = aws_lb_target_group.main_target_group.arn
  target_id        = var.ec2_1a
  port             = 80
}

resource "aws_lb_listener" "main_alb_listner" {
  load_balancer_arn = aws_lb.main_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.main_target_group.arn
    type             = "forward"
  }
}
