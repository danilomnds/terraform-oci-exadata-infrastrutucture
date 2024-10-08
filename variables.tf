variable "availability_domain" {
  type = string
}

variable "cluster_placement_group_id" {
  type    = string
  default = null
}

variable "compartment_id" {
  type = string
}

variable "compute_count" {
  type    = number
  default = null
}

variable "customer_contacts" {
  type = list(object({
    email = string
  }))
  default = [
    {
      email = "youremail@yourdomain.com"
    }]
}

variable "defined_tags" {
  type    = map(string)
  default = null
}

variable "display_name" {
  type = string
}

variable "freeform_tags" {
  type    = map(string)
  default = null
}

variable "maintenance_window" {
  type = object({
    custom_action_timeout_in_mins = optional(number)
    days_of_week = optional(object({
      name = string
    }))
    hours_of_day                     = optional(number)
    is_custom_action_timeout_enabled = optional(bool)
    is_monthly_patching_enabled      = optional(bool)
    lead_time_in_weeks               = optional(number)
    months = optional(object({
      name = string
    }))
    patching_mode  = optional(string)
    preference     = optional(string)
    weeks_of_month = optional(number)
  })
  default = null
}

variable "shape" {
  type = string
}

variable "storage_count" {
  type    = string
  default = null
}

variable "subscription_id" {
  type    = string
  default = null
}

variable "groups" {
  type    = list(string)
  default = []
}

variable "compartment" {
  type    = string
  default = null
}