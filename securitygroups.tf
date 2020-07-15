resource "aws_security_group" "allow_ssh_http_mysql" {
  name        = "quiz3InstanceSg"
  description = "security group for instance"
  vpc_id      = aws_vpc.quiz3-vpc.id

  ingress {
    description = "allow http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow mysql"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "quiz3InstanceSg"
  }
}

resource "aws_security_group" "allow_ssh_http" {
  name        = "quiz3AsgSg"
  description = "security group for auto scaling group"
  vpc_id      = aws_vpc.quiz3-vpc.id

  ingress {
    description = "allow http"
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.allow_http.id]
  }

  ingress {
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "quiz3AsgSg"
  }
}

resource "aws_security_group" "allow_http" {
  name        = "quiz3LbSg"
  description = "security group for load balancer"
  vpc_id      = aws_vpc.quiz3-vpc.id

  ingress {
    description = "allow http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "quiz3LbSg"
  }
}