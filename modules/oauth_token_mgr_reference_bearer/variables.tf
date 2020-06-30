variable "name" {
  description = "The name for the oauth token manager"
}

variable "instance_id" {
  description = "The unique ID for the oauth token manager"
}

variable "extended_attributes" {
  description = "The extended attributes for the oauth token manager"
  type = list(string)
}