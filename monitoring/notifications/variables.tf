variable "rules" {
  description = "Rules parameters"
  type = map(object({
    compartment_id      = string,
    description         = string,
    condition           = string,
    is_enabled          = bool,
    actions_action_type = string,
    actions_is_enabled  = bool,
    actions_description = string,
    topic_id            = string,
    display_name        = string,
    freeform_tags       = map(string)
  }))
}