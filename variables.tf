variable "region" {
  description = "AWS region where the resources will be created"
  default     = "us-east-1"
  type        = string
}

variable "kubernetes-version" {
  description = "Kubernetes version for the EKS cluster"
  default     = "1.32"
  type        = string
}

variable "cidr" {
  description = "CIDR block value for the VPC"
  default     = "10.0.0.0/16"
  type        = string
}

variable "private-subnet" {
  description = "Private subnet array for the VPC"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
  type        = set(string)
}

variable "public-subnet" {
  description = "Public subnet array for the VPC"
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
  type        = set(string)
}
