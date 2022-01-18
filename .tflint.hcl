config {
  plugin_dir          = "~/.tflint.d/plugins"
  module              = false
  force               = false
  disabled_by_default = false
}

rule "terraform_naming_convention" {
  enabled = true
  format  = "snake_case"
  module {
      custom = "^[a-zA-Z]+(-[a-zA-Z]+)*$"
  }
}

rule "terraform_documented_variables" {
    enabled = true
}

rule "terraform_documented_outputs" {
    enabled = true
}

rule "terraform_comment_syntax" {
    enabled = true
}

rule "terraform_typed_variables" {
    enabled = true
}

rule "terraform_deprecated_index" {
    enabled = true
}

rule "terraform_unused_declarations" {
    enabled = true
}
