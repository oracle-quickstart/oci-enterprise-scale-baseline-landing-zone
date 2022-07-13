variable "topics" {
  type = map(object({
    compartment_id   = string
    name             = string
    description      = string
    freeform_tags    = map(string)
  }))
}