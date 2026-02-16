variable "environment" {
  description = "Environment name (dev, test, prod)"
  type        = string
}

variable "vm_name" {
  description = "Base VM name"
  type        = string
}

variable "network_name" {
  description = "vpc-mon"
  type        = string
}

variable "subnetwork_name" {
  description = "Subnet name"
  type        = string
}

variable "vm_count" {
  type    = number
  default = 3
}
variable "project_id" {

  description = "monitoring-482610"
  type        = string
}
variable "region" {
  description = "asia-south1"
  type        = string
}
variable "zone" {
  description = "asia-south1-b"
  type        = string
  default     = "asia-south1-b"
}
variable "machine_type" {
  description = "GCE machine type for the app VM"
  type        = string
  default     = "e2-medium"
}

variable "sa_key_path" {
  description = "path to service account key file"
  type        = string
  default     = "D:\\dev-ops\\terraform\\project-mon\\key.json"
}
variable "vm_names_list" {
  description = "List of VM names"
  type        = list(string)
  default     = ["app-vm-1", "app-vm-2"] # Example default names
}