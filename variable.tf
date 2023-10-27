variable "storage_account_list" {
  type        = list(any)
  default     = []
  description = "list of storage account objects "
}

variable "resource_group_output" {
  type        = map(any)
  default     = {}
  description = "Outputs of resource group objects "
}

variable "subnet_output" {
  type        = map(any)
  default     = {}
  description = "subnet output"
}

variable "default_values" {
  type        = any
  default     = {}
  description = "Provide default values for resources if not any"
}