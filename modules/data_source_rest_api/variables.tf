variable "auth_method" {
  description = "authentication method for rest api"
  type        = string
  default     = "none"

}

variable "https_hostname_verification" {
  description = "Enable HTTPS Hostname Verification"
  type        = string
  default     = "true"
}

variable "read_timeout" {
  description = "Read Timeout (ms)"
  type        = string
  default     = "10000"
}

variable "connection_timeout" {
  description = "Connection Timeout (ms)"
  type        = string
  default     = "10000"
}

variable "max_payload" {
  description = "Max Payload Size (KB)"
  type        = string
  default     = "1024"
}

variable "retry_request" {
  description = "Retry Request"
  type        = string
  default     = "true"
}

variable "max_retry_request" {
  description = "Maximum Retries Limit"
  type        = string
  default     = "5"
}

variable "retry_error_code" {
  description = "Retry Error Codes"
  type        = string
  default     = "429"
}

variable "client_id" {
  description = "OAuth Client ID"
  type        = string
}

variable "client_secret" {
  description = "OAuth Client Secret"
  type        = string
  sensitive   = true
}

variable "oauth_scopes" {
  description = "OAuth Request Scopes"
  type        = list(string)
}

variable "token_endpoint" {
  description = "OAuth Token Endpoint"
  type        = string
}

variable "basic_username" {
  description = "Username of Basic User"
  type        = string
}

variable "basic_password" {
  description = "Password of Basic User"
  type        = string
  sensitive   = true
}

variable "test_url" {
  description = "Test Connection URL"
  type        = string
}
