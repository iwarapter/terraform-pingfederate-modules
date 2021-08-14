terraform {
  required_version = ">= 0.12.26"

  required_providers {
    pingfederate = {
      source  = "iwarapter/pingfederate"
      version = "0.0.19"
    }
  }
}
