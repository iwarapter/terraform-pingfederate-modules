variable "name" {
  description = "name of the datas ource"
  type        = string
}

variable "baseURL" {
  description = "baseURL for rest api"
  type        = string
}

variable "auth_method" {
  description = "authentication method for rest api"
  type        = string
  default     = "None"
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
  default     = null
}

variable "client_secret" {
  description = "OAuth Client Secret"
  type        = string
  sensitive   = true
  default     = null
}

variable "oauth_scopes" {
  description = "OAuth Request Scopes"
  type        = string
  default     = null
}

variable "token_endpoint" {
  description = "OAuth Token Endpoint"
  type        = string
  default     = null
}

variable "basic_username" {
  description = "Username of Basic User"
  type        = string
  default     = null
}

variable "basic_password" {
  description = "Password of Basic User"
  type        = string
  sensitive   = true
  default     = null
}

variable "test_url" {
  description = "Test Connection URL"
  type        = string
  default     = null
}

variable "api_attributes" {
  type = map(object({
    local = string
    json  = string
  }))
  description = "attributes to return from the api"
}

variable "http_request_headers" {
  type = map(object({
    header_name  = string
    header_value = string
  }))
  description = "http request headers send to the api"
}
