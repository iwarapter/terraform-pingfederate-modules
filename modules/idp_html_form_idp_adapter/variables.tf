variable "bypass_external_validation" {
  description = "Whether to bypass validation on creation/update (PF 10+)"
  type        = bool
  default     = false
}

variable "name" {
  description = "The name for the idp adapter"
  type        = string
}

variable "password_credential_validator_id" {
  description = "The ID for the password credential validator"
  type        = string
}

variable "challenge_retries" {
  description = "Number of failed user authentications after which the PingFederate account locking service blocks future attempts."
  default     = 3
  type        = number
}

variable "session_state" {
  description = "Determines how state is maintained within one adapter or between different adapter instances. To take advantage of additional features, it is recommended to use a PingFederate Authentication Session rather than this adapter's internal Session State capability."
  default     = "None"
  type        = string

  validation {
    condition     = contains(["Globally", "Per Adapter", "None"], var.session_state)
    error_message = "The session_state must be either 'Globally', 'Per Adapter' or 'None'."
  }
}

variable "session_timeout" {
  description = "Session Idle Timeout (in minutes). If left blank the timeout will be the Session Max Timeout. Ignored if 'None' is selected for Session State."
  default     = 60
  type        = number
}

variable "session_max_timeout" {
  description = "Session Max Timeout (in minutes). Leave blank for indefinite sessions. Ignored if 'None' is selected for Session State."
  default     = 480
  type        = number
}

variable "allow_password_changes" {
  description = "Allows users to change their password using this adapter."
  default     = false
  type        = bool
}

variable "enable_remember_my_username" {
  description = "Allows users to store their username as a cookie when authenticating with this adapter. Once stored, the username is pre-populated in the login form's username field on subsequent transactions."
  default     = false
  type        = bool
}

variable "enable_this_is_my_device" {
  description = "Allows users to indicate whether their device is shared or private. In this mode, PingFederate Authentication Sessions will not be stored unless the user indicates the device is private. This adapter's internal session tracking (if enabled) will not be affected by the user's selection."
  default     = false
  type        = bool
}

variable "change_password_email_notification" {
  description = "Send users a notification upon a password change. This feature relies on the underlying PCV returning 'mail' and 'givenName' attributes containing the user's first name and e-mail address. Additionally, a notification publisher must be configured."
  default     = false
  type        = bool
}

variable "show_password_expiring_warning" {
  description = "Show a warning message to the user on login about an approaching password expiration."
  default     = false
  type        = bool
}

variable "password_reset_type" {
  description = "Select the method to use for self-service password reset."
  default     = "NONE"
  type        = string

  validation {
    condition     = contains(["NONE", "POLICY", "OTL", "OTP", "PingID", "SMS"], var.password_reset_type)
    error_message = "The session_state must be either 'NONE', 'POLICY', 'OTL', 'OTP', 'PingID', 'SMS'."
  }
}

variable "notification_publisher" {
  description = "Optionally associate this instance with a notification delivery mechanism."
  default     = null
  type        = string
}

variable "attribute_contract_fulfillment" {
  description = "Attribute contract fulfillment mapping for the IDP adapter"
  type = map(object({
    source_type = string
    value       = string
  }))
  default = {
    "policy.action" = {
      source_type = "ADAPTER"
      value       = "policy.action"
    },
    "username" = {
      source_type = "ADAPTER"
      value       = "username"
    }
  }
}

variable "core_attributes" {
  description = "A list of IdP adapter attributes that correspond to the attributes exposed by the IdP adapter type."
  type = list(object({
    name      = string
    pseudonym = bool
    masked    = bool
  }))
  default = [
    {
      name      = "policy.action"
      pseudonym = false
      masked    = false
    },
    {
      name      = "username"
      pseudonym = true
      masked    = false
    }
  ]
}

variable "extended_attributes" {
  description = "A list of additional attributes that can be returned by the IdP adapter. The extended attributes are only used if the adapter supports them."
  type = list(object({
    name      = string
    pseudonym = bool
    masked    = bool
  }))
  default = []
}
