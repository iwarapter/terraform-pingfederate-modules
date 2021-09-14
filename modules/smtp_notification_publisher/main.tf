terraform {
  required_version = ">= 0.14"
  required_providers {
    pingfederate = {
      source  = "iwarapter/pingfederate"
      version = "~> 0.0.16"
    }
  }
}

data "pingfederate_version" "instance" {}

locals {
  isPF10_2 = length(regexall("10.[1-9]", data.pingfederate_version.instance.version)) > 0
}

resource "pingfederate_notification_publisher" "pingfederate_notification_publisher" {
  name         = var.name
  publisher_id = var.name
  plugin_descriptor_ref {
    id = "com.pingidentity.email.SmtpNotificationPlugin"
  }

  configuration {
    fields {
      name  = "From Address"
      value = var.from_address
    }
    fields {
      name  = "Email Server"
      value = var.email_server
    }
    fields {
      name  = "SMTP Port"
      value = var.smtp_port
    }
    fields {
      name  = "Encryption Method"
      value = var.encryption_method
    }
    fields {
      name  = "SMTPS Port"
      value = var.smtps_port
    }
    fields {
      name  = "Verify Hostname"
      value = var.verify_hostname
    }
    fields {
      name  = "Username"
      value = var.username
    }
    sensitive_fields {
      inherited = false
      name      = "Password"
      value     = var.password
    }
    fields {
      name  = "Test Address"
      value = var.test_address
    }
    fields {
      name  = "Connection Timeout"
      value = var.connection_timeout
    }
    fields {
      name  = "Retry Attempt"
      value = var.retry_attempt
    }
    fields {
      name  = "Retry Delay"
      value = var.retry_delay
    }
    fields {
      name  = "Enable SMTP Debugging Messages"
      value = var.enable_smtp_debugging_messages
    }
    dynamic "fields" {
      for_each = local.isPF10_2 ? [1] : []
      content {
        name  = "UTF-8 Message Header Support"
        value = var.utf_8_message_header_support
      }
    }
  }
}
