module "smtp_notification_publisher" {
  source       = "../../modules/smtp_notification_publisher"
  name         = "foo"
  publisher_id = "foo"
  from_address = "someone@foo.com"
  email_server = "server.foo.com"
  username     = "foo"
  password     = "foo"
}
