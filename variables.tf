variable "my_ip" {
  description = "My public IP address for RDS access"
  type        = string
}

variable "existing_key_pair_name" {
  description = "Existing AWS key pair name for EC2"
  type        = string
}

variable "username" {
  description = "RDS username"
  type        = string
  default     = "admin"  # The admin is s stuck standardf name, so i consider it as a Non-sensitive info. although its not to display it in variable file that is pushed
}

variable "password" {
  description = "RDS password"
  type        = string
  sensitive   = true     # i use this attributte to mark tthe password  as sensitive so that Terraform hides it in output and i can initually push it to repo. while parsing it in spaceliftt
}
