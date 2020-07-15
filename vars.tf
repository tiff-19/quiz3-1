variable "REGION" {
    description = "aws region"
    default     = "ap-southeast-1"
}

variable "INSTANCE_NAME" {
    default = "webserver"
}

variable "AMIS" {
    description = "AMIS to use"
    default     = {
        ap-southeast-1a = "ami-063e3af9d2cc7fe94"
        ap-southeast-1b = "ami-02b6d9703a69265e9"
    }
}

variable "INSTANCE_TYPE" {
    default = "t2.micro"
}

variable "KEY_NAME" {
    default = "terraform-key"
}