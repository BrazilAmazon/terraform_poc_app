variable "appservice_windows" {
    type = map(object({
      name = string
      resource_group_name = string
      location = string
      service_plan_id = string
    }))
}
