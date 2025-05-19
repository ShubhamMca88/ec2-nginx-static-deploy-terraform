variable "ami_id" {
  description = "AMI ID to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.medium"
}

variable "instance_name" {
  description = "Name tag for the instance"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH"
  type        = string
}

variable "public_key_path" {
  description = "Path to the public key file"
}

variable "volume_size" {
  description = "Size of the root EBS volume in GB"
  type        = number
  default     = 8
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default = {
    "Environment" = "personal"
    "Owner"       = "Shubham"
    "Project"     = "MultiPurposeEC2"
  }
}
variable "project" {
  description = "Project or environment name"
  type        = string
}

variable "availability_zone" {
  description = "AWS availability zone"
  type        = string
}
