# https://github.com/terraform-linters/tflint/blob/master/docs/guides/config.md

config {
  # TFLint can also inspect modules. In this case, it checks based on the input variables passed to the calling module.
  module     = false
  # Return zero exit status even if issues found
  force      = false
}

rule "terraform_documented_outputs" {
  enabled = true
}

rule "terraform_documented_variables" {
  enabled = true
}

rule "terraform_deprecated_interpolation" {
  enabled = true
}

rule "terraform_module_pinned_source" {
  enabled = false
  style = "flexible"
}
