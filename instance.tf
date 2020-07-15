module "module_instance" {
  source                 = "github.com/tiff-19/quiz3.git"
  INSTANCE_NAME          = var.INSTANCE_NAME
  REGION                 = var.REGION
  AMIS                   = var.AMIS
  INSTANCE_TYPE          = var.INSTANCE_TYPE
  KEY_NAME               = var.KEY_NAME
  
#   subnet_id              = [aws_subnet.quiz3-public-1.id, aws_subnet.quiz3-public-2.id]
#   monitoring             = true
#   vpc_security_group_ids = [aws_security_group.allow_ssh_http_mysql.id]

#   tags = {
#     Terraform   = "true"
#     Environment = "dev"
#   }
}