variable "turn_on" {
  type        = string
  description = "It is used to turn on the null resources based on conditions."
}

variable "storage_turn_on" {
  type        = string
  description = "To determine the storage cluster is enabled or not."
}

variable "compute_turn_on" {
  type        = string
  description = "To determine the compute cluster is enabled or not."
}

variable "create_scale_cluster" {
  type        = string
  description = "It enables scale cluster configuration."
}

variable "clone_path" {
  type        = string
  description = "Scale repo clone path"
}
