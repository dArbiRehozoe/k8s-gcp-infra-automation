variable "gcp_project" {
  type        = string
  default     = "elevated-apex-403206"
  description = "The GCP project to deploy the runner into."
}
variable "gcp_zone" {
  type        = string
  default     = "us-east1-b"
  description = "The GCP zone to deploy the runner into."
}

variable "gcp_region" {
  type        = string
  default     = "us-east1"
  description = "The GCP region to deploy the runner into."
}
variable "ci_runner_instance_type" {
  type        = string
  default     = "n1-standard-1"
}

variable "image" {
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "hostnamenodemaster" {
  type        = string
  default     = "nodemaster.darbi.com"
}

variable "hostnamenodeworker" {
  type        = string
  default     = "nodeworker.darbi.com"
}
variable "base_ip_address" {
  default = "20.20.20."
}