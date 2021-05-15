terraform {
  required_providers {
    pingfederate = {
      source  = "iwarapter/pingfederate"
      version = "~> 0.0.16"
    }
  }
}

provider "pingfederate" {
  bypass_external_validation = var.bypass_external_validation
}

locals {
  isPF10_2 = length(regexall("10.[2]", var.pingfederate_version)) > 0
}
resource "pingfederate_idp_adapter" "adapter" {
  name = var.name
  plugin_descriptor_ref {
    id = "com.pingidentity.adapters.htmlform.idp.HtmlFormIdpAuthnAdapter"
  }

  configuration {
    tables {
      name = "Credential Validators"
      rows {
        fields {
          name  = "Password Credential Validator Instance"
          value = var.password_credential_validator_id
        }
      }
    }

    dynamic "fields" {
      for_each = local.isPF10_2 ? [1] : []
      content {
        name = "Change Password Policy Contract"
      }
    }

    dynamic "fields" {
      for_each = local.isPF10_2 ? [1] : []
      content {
        name  = "Revoke Sessions After Password Change Or Reset"
        value = "false"
      }
    }

    fields {
      name  = "Challenge Retries"
      value = var.challenge_retries
    }
    fields {
      name  = "Session State"
      value = var.session_state
    }
    fields {
      name  = "Session Timeout"
      value = var.session_timeout
    }
    fields {
      name  = "Session Max Timeout"
      value = var.session_max_timeout
    }
    fields {
      name  = "Allow Password Changes"
      value = var.allow_password_changes
    }
    fields {
      name  = "Password Management System"
      value = var.password_management_system
    }
    fields {
      name  = "Enable 'Remember My Username'"
      value = var.enable_remember_my_username
    }
    fields {
      name  = "Enable 'This is My Device'"
      value = var.enable_this_is_my_device
    }
    fields {
      name  = "Change Password Email Notification"
      value = var.change_password_email_notification
    }
    fields {
      name  = "Show Password Expiring Warning"
      value = var.show_password_expiring_warning
    }
    fields {
      name  = "Password Reset Type"
      value = var.password_reset_type
    }
    fields {
      name  = "Password Reset Policy Contract"
      value = var.password_reset_policy_contract
    }
    fields {
      name  = "Account Unlock"
      value = var.account_unlock
    }
    fields {
      name  = "Local Identity Profile"
      value = var.local_identity_profile
    }
    fields {
      name  = "Notification Publisher"
      value = var.notification_publisher
    }
    fields {
      name  = "Enable Username Recovery"
      value = var.enable_username_recovery
    }
    fields {
      name  = "Login Template"
      value = var.login_template
    }
    fields {
      name  = "Logout Path"
      value = var.logout_path
    }
    fields {
      name  = "Logout Redirect"
      value = var.logout_redirect
    }
    fields {
      name  = "Logout Template"
      value = var.logout_template
    }
    fields {
      name  = "Change Password Template"
      value = var.change_password_template
    }
    fields {
      name  = "Change Password Message Template"
      value = var.change_password_message_template
    }
    fields {
      name  = "Password Management System Message Template"
      value = var.password_management_system_message_template
    }
    fields {
      name  = "Change Password Email Template"
      value = var.change_password_email_template
    }
    fields {
      name  = "Expiring Password Warning Template"
      value = var.expiring_password_warning_template
    }
    fields {
      name  = "Threshold for Expiring Password Warning"
      value = var.threshold_for_expiring_password_warning
    }
    fields {
      name  = "Snooze Interval for Expiring Password Warning"
      value = var.snooze_interval_for_expiring_password_warning
    }
    fields {
      name  = "Login Challenge Template"
      value = var.login_challenge_template
    }
    fields {
      name  = "'Remember My Username' Lifetime"
      value = var.remember_my_username_lifetime
    }
    fields {
      name  = "'This is My Device' Lifetime"
      value = var.this_is_my_device_lifetime
    }
    fields {
      name  = "Allow Username Edits During Chaining"
      value = var.allow_username_edits_during_chaining
    }
    fields {
      name  = "Track Authentication Time"
      value = var.track_authentication_time
    }
    fields {
      name  = "Post-Password Change Re-Authentication Delay"
      value = var.post_password_change_re_authentication_delay
    }
    fields {
      name  = "Password Reset Username Template"
      value = var.password_reset_username_template
    }
    fields {
      name  = "Password Reset Code Template"
      value = var.password_reset_code_template
    }
    fields {
      name  = "Password Reset Template"
      value = var.password_reset_template
    }
    fields {
      name  = "Password Reset Error Template"
      value = var.password_reset_error_template
    }
    fields {
      name  = "Password Reset Success Template"
      value = var.password_reset_success_template
    }
    fields {
      name  = "Account Unlock Template"
      value = var.account_unlock_template
    }
    fields {
      name  = "OTP Length"
      value = var.otp_length
    }
    fields {
      name  = "OTP Time to Live"
      value = var.otp_time_to_live
    }
    fields {
      name  = "PingID Properties"
      value = var.ping_id_properties
    }
    fields {
      name  = "Require Verified Email"
      value = var.require_verified_email
    }
    fields {
      name  = "Username Recovery Template"
      value = var.username_recovery_template
    }
    fields {
      name  = "Username Recovery Info Template"
      value = var.username_recovery_info_template
    }
    fields {
      name  = "Username Recovery Email Template"
      value = var.username_recovery_email_template
    }
    fields {
      name  = "CAPTCHA for Authentication"
      value = var.captcha_for_authentication
    }
    fields {
      name  = "CAPTCHA for Password change"
      value = var.captcha_for_password_change
    }
    fields {
      name  = "CAPTCHA for Password Reset"
      value = var.captcha_for_password_reset
    }
    fields {
      name  = "CAPTCHA for Username recovery"
      value = var.captcha_for_username_recovery
    }
  }

  attribute_mapping {
    dynamic "attribute_contract_fulfillment" {
      for_each = var.attribute_contract_fulfillment
      content {
        key_name = attribute_contract_fulfillment.key
        source {
          type = attribute_contract_fulfillment.value["source_type"]
        }
        value = attribute_contract_fulfillment.value["value"]
      }
    }
  }

  attribute_contract {
    dynamic "core_attributes" {
      for_each = var.core_attributes
      content {
        name      = core_attributes.value["name"]
        masked    = core_attributes.value["masked"]
        pseudonym = core_attributes.value["pseudonym"]
      }
    }
    dynamic "extended_attributes" {
      for_each = var.extended_attributes
      content {
        name      = extended_attributes.value["name"]
        masked    = extended_attributes.value["masked"]
        pseudonym = extended_attributes.value["pseudonym"]
      }
    }
  }
}
