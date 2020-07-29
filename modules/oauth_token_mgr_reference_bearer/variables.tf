variable "name" {
  description = "The name for the oauth token manager"
}

variable "instance_id" {
  description = "The unique ID for the oauth token manager"
}

variable "extended_attributes" {
  description = "The extended attributes for the oauth token manager"
  type = list(string)
}

variable "token_length" {
  description = "The Token Length"
  type = string
  default = "28"
}

variable "token_lifetime" {
  description = "The Token Lifetime"
  type = string
  default = "120"
}

variable "lifetime_policy" {
  description = "Lifetime Extension Policy"
  type = string
  default = "ALL"
}


variable "maximum_token_lifetime" {
  description = "Maximum Token Lifetime"
  type = string
  default = ""
}

variable "lifetime_extention_threshold" {
  description = "Lifetime Extension Threshold Percentage"
  type = string
  default = "30"
}

variable "mode_sync" {
  description = "Mode for Synchronous RPC"
  type = string
  default = "3"
}

variable "rpc_timeout" {
  description = "RPC Timeout"
  type = string
  default = "500"
}

variable "expanded_scopes" {
  description = "Expand Scope Groups"
  type = string
  default = "false"
}