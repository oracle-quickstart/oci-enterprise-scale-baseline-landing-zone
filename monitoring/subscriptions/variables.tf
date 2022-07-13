variable "subscriptions" {
  type = map(object({
    compartment_id  = string
    topic_id        = string
    protocol        = string
    endpoint        = string
    freeform_tags   = map(string)
  }))
}