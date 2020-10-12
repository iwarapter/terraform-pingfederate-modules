terraform {
  required_providers {
    pingfederate = {
      source  = "iwarapter/pingfederate"
      version = "~> 0.0.5"
    }
  }
}

resource "pingfederate_idp_adapter" "adapter" {
  bypass_external_validation = var.bypass_external_validation
  name                       = var.name
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
      name = "Password Management System"
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
      name = "Password Reset Policy Contract"
    }
    fields {
      name  = "Account Unlock"
      value = "false"
    }
    fields {
      name = "Local Identity Profile"
    }
    fields {
      name  = "Notification Publisher"
      value = var.notification_publisher
    }
    fields {
      name  = "Enable Username Recovery"
      value = "false"
    }
    fields {
      name  = "Login Template"
      value = "html.form.login.template.html"
    }
    fields {
      name = "Logout Path"
    }
    fields {
      name = "Logout Redirect"
    }
    fields {
      name  = "Logout Template"
      value = "idp.logout.success.page.template.html"
    }
    fields {
      name  = "Change Password Template"
      value = "html.form.change.password.template.html"
    }
    fields {
      name  = "Change Password Message Template"
      value = "html.form.message.template.html"
    }
    fields {
      name  = "Password Management System Message Template"
      value = "html.form.message.template.html"
    }
    fields {
      name  = "Change Password Email Template"
      value = "message-template-end-user-password-change.html"
    }
    fields {
      name  = "Expiring Password Warning Template"
      value = "html.form.password.expiring.notification.template.html"
    }
    fields {
      name  = "Threshold for Expiring Password Warning"
      value = "7"
    }
    fields {
      name  = "Snooze Interval for Expiring Password Warning"
      value = "24"
    }
    fields {
      name  = "Login Challenge Template"
      value = "html.form.login.challenge.template.html"
    }
    fields {
      name  = "'Remember My Username' Lifetime"
      value = "30"
    }
    fields {
      name  = "'This is My Device' Lifetime"
      value = "30"
    }
    fields {
      name  = "Allow Username Edits During Chaining"
      value = "false"
    }
    fields {
      name  = "Track Authentication Time"
      value = "true"
    }
    fields {
      name  = "Post-Password Change Re-Authentication Delay"
      value = "0"
    }
    fields {
      name  = "Password Reset Username Template"
      value = "forgot-password.html"
    }
    fields {
      name  = "Password Reset Code Template"
      value = "forgot-password-resume.html"
    }
    fields {
      name  = "Password Reset Template"
      value = "forgot-password-change.html"
    }
    fields {
      name  = "Password Reset Error Template"
      value = "forgot-password-error.html"
    }
    fields {
      name  = "Password Reset Success Template"
      value = "forgot-password-success.html"
    }
    fields {
      name  = "Account Unlock Template"
      value = "account-unlock.html"
    }
    fields {
      name  = "OTP Length"
      value = "8"
    }
    fields {
      name  = "OTP Time to Live"
      value = "10"
    }
    fields {
      name = "PingID Properties"
    }
    fields {
      name  = "Require Verified Email"
      value = "false"
    }
    fields {
      name  = "Username Recovery Template"
      value = "username.recovery.template.html"
    }
    fields {
      name  = "Username Recovery Info Template"
      value = "username.recovery.info.template.html"
    }
    fields {
      name  = "Username Recovery Email Template"
      value = "message-template-username-recovery.html"
    }
    fields {
      name  = "CAPTCHA for Authentication"
      value = "false"
    }
    fields {
      name  = "CAPTCHA for Password change"
      value = "false"
    }
    fields {
      name  = "CAPTCHA for Password Reset"
      value = "false"
    }
    fields {
      name  = "CAPTCHA for Username recovery"
      value = "false"
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
