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
    # defined_tags        = map(string)
    freeform_tags       = map(string)
  }))
}