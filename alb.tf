resource "aws_lb" "quiz3-alb" {
  name               = "quiz3-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = [aws_subnet.quiz3-public-1.id, aws_subnet.quiz3-public-2.id, aws_subnet.quiz3-public-3.id]

  enable_deletion_protection = false

  tags = {
    Environment = "staging"
  }
}

resource "aws_lb_target_group" "quiz3-tg" {
  name     = "quiz3-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.quiz3-vpc.id
}

resource "aws_lb_listener" "quiz3-listener" {
  load_balancer_arn = aws_lb.quiz3-alb.arn
  port              = "80"
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.quiz3-tg.arn
  }
}