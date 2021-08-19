variable "name" {
  description = "name of the datas source"
  type        = string
}

variable "base_url" {
  description = "The base URL of the REST API service."
  type        = string
}

variable "authentication_method" {
  description = "Select the authentication method used to access the REST service."
  type        = string
  default     = "None"
}

variable "enable_https_hostname_verification" {
  description = "When SSL/TLS is used, this specifies whether to check if the hostname for the REST service matches the hostname in the certificate it presents."
  type        = string
  default     = "true"
}

variable "read_timeout" {
  description = "Defines the socket timeout in milliseconds. A timeout value of zero is interpreted as an infinite timeout. A value of -1 will cause the OS level default to be used."
  type        = string
  default     = "10000"
}

variable "connection_timeout" {
  description = "Determines the timeout in milliseconds until a connection is established. A timeout value of zero is interpreted as an infinite timeout. A value of -1 will cause the OS level default to be used."
  type        = string
  default     = "10000"
}

variable "max_payload_size" {
  description = "Defines the maximum allowed size in kilobytes of the returned JSON response payload. A value of zero is interpreted as an unrestricted payload size."
  type        = string
  default     = "1024"
}

variable "retry_request" {
  description = "Retry user data retrieval request if API fails with error codes configured."
  type        = string
  default     = "true"
}

variable "maximum_retries_limit" {
  description = "Maximum number of retries attempted if API fails with error codes configured."
  type        = string
  default     = "5"
}

variable "retry_error_codes" {
  description = "Comma-separated list of error code values for API re-attempt e.g. 429, 503."
  type        = string
  default     = "429"
}

variable "client_id" {
  description = "When using OAuth client credentials grant type, this specifies the ID of the client created in the REST service for authentication."
  type        = string
  default     = null
}

variable "client_secret" {
  description = "When using OAuth client credentials grant type, this specifies the secret of the client created in the REST service authentication."
  type        = string
  sensitive   = true
  default     = null
}

variable "oauth_scope" {
  description = "When using OAuth client credentials grant type, this specifies the space delimited authorization scope(s) requested from the authorization endpoint to access the REST API service."
  type        = string
  default     = null
}

variable "oauth_token_endpoint" {
  description = "When using OAuth client credentials grant type, this specifies the authorization server token endpoint URL."
  type        = string
  default     = null
}

variable "username" {
  description = "The username to use for basic authentication."
  type        = string
  default     = null
}

variable "password" {
  description = "The password to use for basic authentication."
  type        = string
  sensitive   = true
  default     = null
}

variable "test_connection_url" {
  description = "Tests connectivity to the REST service based on the provided Test Connection URL"
  type        = string
  default     = null
}


variable "attributes" {
  type        = map(string)
  description = "Define attributes to expose from this data source. Each named attribute must include a path using JSON Pointer syntax (RFC 6901) from where it is retrieved in the response of the REST API. For example, a JSON Response Attribute Path of /age will return the value of a top-level JSON key called \"age\". Click 'Add a new row ...' to add multiple entries."

}

variable "http_request_headers" {
  type        = map(string)
  description = "Define HTTP headers to include in the request."

}
