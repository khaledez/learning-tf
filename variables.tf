
variable "aws-region" {
  type        = string
  default     = "us-east-2"
  description = "This variable is used for something"
}

variable "aws-key" {
  type      = string
  sensitive = true
}

variable "aws-secret" {
  type      = string
  sensitive = true
}
