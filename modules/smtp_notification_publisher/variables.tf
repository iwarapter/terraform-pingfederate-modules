variable "name" {
  description = "name of the notification publisher"
  type        = string
}

variable "from_address" {
  description = "The email address that appears in the 'From' header line in email messages generated by PingFederate. The address must be in valid format but need not be set up on your system."
  type        = string
}

variable "email_server" {
  description = "The IP address or hostname of your email server."
  type        = string
}

variable "smtp_port" {
  description = "The SMTP port on your email server. The default value is 25."
  type        = string
  default     = "25"
}

variable "encryption_method" {
  description = "Select 'None' (the default) to establish an unencrypted connection to the email server at the SMTP port.\nSelect 'SSL/TLS' to establish a secure connection to the email server at the SMTPS port.\nSelect 'STARTTLS' to establish an unencrypted connection to the email server at the SMTP port and initiate a secure channel afterward."
  type        = string
  default     = "NONE"
}

variable "smtps_port" {
  description = "The secure SMTP port on your email server. This field is not active unless SSL/TLS is the chosen encryption method. The default value is 465."
  type        = string
  default     = "465"
}

variable "verify_hostname" {
  description = "Indicates whether to verify the hostname of the email server matches the Subject (CN) or one of the Subject Alternative Names from the certificate. Applies when either 'SSL/TLS' or 'STARTTLS' is the chosen encryption method."
  type        = string
  default     = "true"
}

variable "username" {
  description = "Authorized email account."
  type        = string
}

variable "password" {
  description = "Password for the authorized email account."
  type        = string
  sensitive   = true
}

variable "test_address" {
  description = "Enter an email address the PingFederate should use to verify connectivity with the configured email server."
  type        = string
  default     = ""
}

variable "connection_timeout" {
  description = "The amount of time in seconds that PingFederate waits before it times out connecting to the SMTP server. The default value is 30."
  type        = string
  default     = "30"
}

variable "retry_attempt" {
  description = "The number of times the PingFederate tries again after encountering an error. The default value is 2."
  type        = string
  default     = "2"
}

variable "retry_delay" {
  description = "The amount of time in minutes that PingFederate waits before trying to send an email notification again. The default value is 2 minutes."
  type        = string
  default     = "2"
}

variable "enable_smtp_debugging_messages" {
  description = "Turns on detailed error messages for the PingFederate server log to help troubleshoot SMTP issues.\n\nWARNING: This setting is disabled by default. When enabled, PingFederate logs email messages, which may contain sensitive information, to the server log."
  type        = string
  default     = "false"
}

variable "utf_8_message_header_support" {
  description = "Indicates whether the email server supports UTF-8 in message headers (E.g. recipient email address). Only enable this if your email server supports this feature."
  type        = string
  default     = "false"
}
