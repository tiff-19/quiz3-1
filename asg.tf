resource "aws_launch_template" "quiz3-as-template" {
  name          = "quiz3_as_template"
  image_id      = var.AMIS[var.REGION]
  instance_type = var.INSTANCE_TYPE
  key_name      = var.KEY_NAME
}

resource "aws_autoscaling_group" "quiz3-asg" {
  name                      = "quiz3-asg"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 60
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  vpc_zone_identifier       = [aws_subnet.quiz3-public-1.id, aws_subnet.quiz3-public-2.id, aws_subnet.quiz3-public-3.id]

  launch_template {
    id      = aws_launch_template.quiz3-as-template.id
    version = "$Latest"
  }
}

resource "aws_autoscaling_policy" "scaleout" {
  name                   = "quiz3-scaleout"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.quiz3-asg.name
}

resource "aws_cloudwatch_metric_alarm" "alarm-so" {
  alarm_name          = "quiz3-alarm-so"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Average"
  threshold           = "50"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.quiz3-asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.scaleout.arn]
}

resource "aws_autoscaling_policy" "scalein" {
  name                   = "quiz3-scalein"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 60
  autoscaling_group_name = aws_autoscaling_group.quiz3-asg.name
}

resource "aws_cloudwatch_metric_alarm" "alarm-s1" {
  alarm_name          = "quiz3-alarm-s1"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ApplicationELB"
  period              = "60"
  statistic           = "Average"
  threshold           = "20"

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.quiz3-asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.scalein.arn]
}