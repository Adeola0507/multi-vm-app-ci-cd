variable "project_id" {
  description = "GCP project ID"
  type        = string
  default     = "terraform-provisioning-503017"
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-east1"
}

variable "zone" {
  description = "GCP zone"
  type        = string
  default     = "us-east1-b"
}

variable "instance_name" {
  description = "Name of the GCP VM"
  type        = string
  default     = "ci-stack-vm"
}

variable "machine_type" {
  description = "GCP machine type"
  type        = string
  default     = "e2-micro"
}

variable "username" {
  description = "Linux username"
  type        = string
  default     = "deola"
}

variable "admin_ip" {
  description = "Your public IP address in CIDR notation"
  type        = string
  default     = "197.211.63.177"
}

variable "repo_url" {
  description = "URL of the GitHub repository to clone"
  type        = string
  default     = "https://github.com/Adeola0507/multi-vm-app-ci-cd"
}