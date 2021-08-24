terraform {
  required_version = ">= 0.14"
  required_providers {
    pingfederate = {
      source  = "iwarapter/pingfederate"
      version = "~> 0.0.16"
    }
  }
}

resource "pingfederate_notification_publisher" "pingfederate_notification_publisher" {
  name         = "example"
  publisher_id = "example"
  plugin_descriptor_ref {
    id = "com.pingidentity.email.SmtpNotificationPlugin"
  }

  configuration {
    fields {
      name  = "From Address"
      value = "help@foo.org"
    }
    fields {
      name  = "Email Server"
      value = "foo"
    }
    fields {
      name  = "SMTP Port"
      value = "25"
    }
    fields {
      name  = "Encryption Method"
      value = "NONE"
    }
    fields {
      name  = "SMTPS Port"
      value = "465"
    }
    fields {
      name  = "Verify Hostname"
      value = "true"
    }
    fields {
      name  = "Username"
      value = ""
    }
    fields {
      name  = "Password"
      value = ""
    }
    fields {
      name  = "Test Address"
      value = ""
    }
    fields {
      name  = "Connection Timeout"
      value = "30"
    }
    fields {
      name  = "Retry Attempt"
      value = "2"
    }
    fields {
      name  = "Retry Delay"
      value = "2"
    }
    fields {
      name  = "Enable SMTP Debugging Messages"
      value = "false"
    }
  }
}
