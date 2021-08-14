variable "bypass_external_validation" {
  description = "Whether to bypass validation on creation/update (PF 10+)"
  type        = bool
  default     = false
}

variable "name" {
  description = "The name for the idp adapter"
  type        = string
}

variable "password_credential_validator_ids" {
  description = "The ID for the password credential validator"
  type        = list(string)
}
variable "challenge_retries" {
  description = "Number of failed user authentications after which the PingFederate account locking service blocks future attempts."
  default     = 3
  type        = number
}

variable "session_state" {
  description = "Determines how state is maintained within one adapter or between different adapter instances"
  default     = "None"
  validation {
    condition     = contains(["Globally", "Per Adapter", "None"], var.session_state)
    error_message = "The session_state must be either 'Globally', 'Per Adapter', 'None'."
  }
}

variable "session_timeout" {
  description = "Session Idle Timeout (in minutes)"
  default     = 60
  type        = number
}

variable "session_max_timeout" {
  description = "Session Max Timeout (in minutes)."
  default     = 480
  type        = number
}

variable "allow_password_changes" {
  description = "Allows users to change their password using this adapter."
  default     = false
  type        = bool
}

variable "change_password_policy_contract" {
  description = "The policy contract to use for change password. Selecting a policy contract will enable usage of Authentication Policy during password change."
  default     = ""
  type        = string
}

variable "password_management_system" {
  description = "A fully-qualified URL to your password management system where users can change their password"
  default     = ""
  type        = string
}

variable "enable_remember_my_username" {
  description = "Allows users to store their username as a cookie when authenticating with this adapter."
  default     = false
  type        = bool
}

variable "enable_this_is_my_device" {
  description = "Allows users to indicate whether their device is shared or private."
  default     = false
  type        = bool
}

variable "change_password_email_notification" {
  description = "Send users a notification upon a password change."
  default     = false
  type        = bool
}

variable "show_password_expiring_warning" {
  description = "Show a warning message to the user on login about an approaching password expiration."
  default     = false
  type        = bool
}

variable "password_reset_type" {
  description = "Select the method to use for self-service password reset"
  default     = "NONE"
  type        = string

  validation {
    condition     = contains(["POLICY", "OTL", "OTP", "PingID", "SMS", "NONE"], var.password_reset_type)
    error_message = "The password_reset_type must be either 'POLICY', 'OTL', 'OTP', 'PingID', 'SMS', 'NONE'."
  }
}

variable "password_reset_policy_contract" {
  description = "The policy contract to use for password reset"
  default     = null
  type        = string
}

variable "revoke_sessions_after_password_change_or_reset" {
  description = "Revokes a user's authentication sessions after a password change or reset is completed by this adapter"
  default     = false
  type        = bool
}

variable "account_unlock" {
  description = "Allows users with a locked account to unlock it using the self-service password reset type"
  default     = false
  type        = bool
}

variable "local_identity_profile" {
  description = "Optionally associate this instance with a Local Identity Profile"
  default     = null
  type        = string
}

variable "notification_publisher" {
  description = "Optionally associate this instance with a notification delivery mechanism"
  default     = null
  type        = string
}

variable "enable_username_recovery" {
  description = "Allow users to get their username from an email"
  default     = false
  type        = bool
}

variable "login_template" {
  description = "HTML template (in <pf_home>/server/default/conf/template) to render for login"
  default     = "html.form.login.template.html"
  type        = string
}

variable "logout_path" {
  description = "Path on the PingFederate server to invoke the HTML Form Adapter logout functionality"
  default     = null
  type        = string
}

variable "logout_redirect" {
  description = "A fully qualified URL, usually at the SP, to which a user will be redirected after logout (applicable only when Logout Path is set above)"
  default     = null
  type        = string
}

variable "logout_template" {
  description = "HTML template (in <pf_home>/server/default/conf/template) to render after logout (applicable only when Logout Path is set above and if Logout Redirect is not provided)"
  default     = "idp.logout.success.page.template.html"
  type        = string
}

variable "change_password_template" {
  description = "HTML template (in <pf_home>/server/default/conf/template) to render for a user to change their password"
  default     = "html.form.change.password.template.html"
  type        = string
}

variable "change_password_message_template" {
  description = "HTML template (in <pf_home>/server/default/conf/template) to render when a user is being redirected after successfully changing their password"
  default     = "html.form.message.template.html"
  type        = string
}

variable "password_management_system_message_template" {
  description = "HTML template (in <pf_home>/server/default/conf/template) to render when a user is being redirected to the password management system to change their password"
  default     = "html.form.message.template.html"
  type        = string
}

variable "change_password_email_template" {
  description = "HTML email template (in <pf_home>/server/default/conf/template/mail-notifications) used to send a changing password email"
  default     = "message-template-end-user-password-change.html"
  type        = string
}

variable "expiring_password_warning_template" {
  description = "HTML template (in <pf_home>/server/default/conf/template) to warn the user about approaching password expiry day"
  default     = "html.form.password.expiring.notification.template.html"
  type        = string
}

variable "threshold_for_expiring_password_warning" {
  description = "Threshold (in days) to start warning the user about approaching password expiry day"
  default     = 7
  type        = number
}

variable "snooze_interval_for_expiring_password_warning" {
  description = "Amount of time (in hours) to wait after a expiring password warning before the next warning"
  default     = 24
  type        = number
}

variable "login_challenge_template" {
  description = "HTML template (in <pf_home>/server/default/conf/template) to render during a strong authentication as a second step"
  default     = "html.form.login.challenge.template.html"
  type        = string
}

variable "remember_my_username_lifetime" {
  description = "Number of days that the username is stored"
  default     = 30
  type        = number
}

variable "this_is_my_device_lifetime" {
  description = "Number of days that the user's 'This is My Device' selection is stored"
  default     = 30
  type        = number
}

variable "allow_username_edits_during_chaining" {
  description = "Allow users to edit the pre-populated username field in the login form"
  default     = false
  type        = bool
}

variable "track_authentication_time" {
  description = "Determines if the time each end user authenticated is tracked"
  default     = true
  type        = bool
}

variable "post_password_change_re_authentication_delay" {
  description = "Amount of time (milliseconds) to wait after a successful password change before automatically re-authenticating the user against the Password Credential Validator using the new password"
  default     = 0
  type        = number
}

variable "password_reset_username_template" {
  description = "HTML template (in <pf_home>/server/default/conf/template) rendered to prompt a user for their username during password reset"
  default     = "forgot-password.html"
  type        = string
}

variable "password_reset_code_template" {
  description = "HTML template (in <pf_home>/server/default/conf/template) rendered to prompt a user for a code challenge during password reset"
  default     = "forgot-password-resume.html"
  type        = string
}

variable "password_reset_template" {
  description = "HTML template (in <pf_home>/server/default/conf/template) rendered to prompt a user to define their new password during password reset"
  default     = "forgot-password-change.html"
  type        = string
}

variable "password_reset_error_template" {
  description = "HTML template (in <pf_home>/server/default/conf/template) to render when an error occurs during password reset"
  default     = "forgot-password-error.html"
  type        = string
}

variable "password_reset_success_template" {
  description = "HTML template (in <pf_home>/server/default/conf/template) rendered upon a successful password reset"
  default     = "forgot-password-success.html"
  type        = string
}

variable "account_unlock_template" {
  description = "HTML template (in <pf_home>/server/default/conf/template) rendered when a user's account is sucessfully unlocked"
  default     = "account-unlock.html"
  type        = string
}

variable "otp_length" {
  description = "For self-service password reset, the number of characters used in one-time passwords"
  default     = 8
  type        = number
}

variable "otp_time_to_live" {
  description = "For self-service password reset, the validity period (in minutes) for password reset tokens"
  default     = 10
  type        = number
}

variable "ping_id_properties" {
  description = "For self-service password reset using PingID, upload your pingid"
  default     = null
  type        = string
}

variable "require_verified_email" {
  description = "The user’s email address has to be verified before a password reset, account unlock or username recovery email is sent"
  default     = false
  type        = bool
}

variable "username_recovery_template" {
  description = "HTML template (in <pf_home>/server/default/conf/template) rendered to prompt a user for their email address during username recovery"
  default     = "username.recovery.template.html"
  type        = string
}

variable "username_recovery_info_template" {
  description = "HTML template (in <pf_home>/server/default/conf/template) rendered to prompt a user to check their email for their recovered username"
  default     = "username.recovery.info.template.html"
  type        = string
}

variable "username_recovery_email_template" {
  description = "HTML email template (in <pf_home>/server/default/conf/template/mail-notifications) used to send a username recovery email"
  default     = "message-template-username-recovery.html"
  type        = string
}

variable "captcha_for_authentication" {
  description = "CAPTCHA can be enabled for the login form to prevent automated attacks"
  default     = false
  type        = bool
}

variable "captcha_for_password_change" {
  description = "CAPTCHA can be enabled for the password change form to prevent automated attacks"
  default     = false
  type        = bool
}

variable "captcha_for_password_reset" {
  description = "CAPTCHA can be enabled for password reset and account unlock features to prevent automated attacks"
  default     = false
  type        = bool
}

variable "captcha_for_username_recovery" {
  description = "CAPTCHA can be enabled for username recovery features to prevent automated attacks"
  default     = false
  type        = bool
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

variable "extended_attributes" {
  description = "A list of additional attributes that can be returned by the IdP adapter. The extended attributes are only used if the adapter supports them."
  type = list(object({
    name      = string
    pseudonym = bool
    masked    = bool
  }))
  default = []
}
