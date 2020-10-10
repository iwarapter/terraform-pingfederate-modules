variable "name" {
  description = "The name for the oauth token manager"
}

variable "instance_id" {
  description = "The unique ID for the oauth token manager"
  default     = null
}

variable "extended_attributes" {
  description = "The extended attributes for the oauth token manager"
  type        = list(string)
  default     = []
}

variable "token_length" {
  description = "Defines how many alphanumeric characters make up an access token. Note that the first 4 characters are reserved and don't count towards the randomness of the token."
  default     = "28"
  type        = string
}

variable "token_lifetime" {
  description = "Defines how long, in minutes, an access token is valid."
  default     = "120"
  type        = string
}

variable "lifetime_extension_policy" {
  description = "Dictates which tokens are eligible for lifetime extension. Similar to a session inactivity timeout, the lifetime period of an access token can be reset each time the token is validated at the AS (subject to the values defined for the Lifetime Extension Threshold Percentage and the Maximum Token Lifetime)."
  default     = "NONE"
  type        = string

  validation {
    condition     = contains(["ALL", "TRANSIENT", "NONE"], var.lifetime_extension_policy)
    error_message = "The lifetime_extension_policy must be one of 'ALL', 'TRANSIENT', 'NONE'."
  }
}

variable "maximum_token_lifetime" {
  description = "(Optional) Defines an absolute maximum token lifetime, in minutes, for use with the Lifetime Extension Policy. An access token's lifetime cannot be extended beyond this setting."
  default     = ""
  type        = string
}

variable "lifetime_extension_threshold_percentage" {
  description = "Defines the percentage of a token's lifetime remaining before the lifetime is actually extended, which can improve cluster performance."
  default     = "30"
  type        = string
}

variable "mode_for_synchronous_rpc" {
  description = "For clustered deployments, indicates how many responses to wait for when making synchronous RPC calls. When 'Majority of Nodes' is selected, the server waits for the majority of recipients to respond. When 'All Nodes' is selected, it waits for all recipients to respond."
  default     = "3"
  type        = string

  validation {
    condition     = contains(["2", "3"], var.mode_for_synchronous_rpc)
    error_message = "The mode_for_synchronous_rpc must be either '3' (Majority) or '2' (All)."
  }
}

variable "rpc_timeout" {
  description = "For clustered deployments, indicates how long, in milliseconds, the server waits before timing out unresponsive RPC invocations."
  default     = "500"
  type        = string
}

variable "expand_scope_groups" {
  description = "Expand scope groups into their corresponding scopes in the Access Token contents and introspection response. By default this is disabled."
  default     = "false"
  type        = string

  validation {
    condition     = contains(["true", "false"], var.expand_scope_groups)
    error_message = "The expand_scope_groups must be either 'true' or 'false'."
  }
}
