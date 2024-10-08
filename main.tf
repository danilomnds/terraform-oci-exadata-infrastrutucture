resource "oci_database_cloud_exadata_infrastructure" "exadata_infrastructure" {
  availability_domain        = var.availability_domain
  cluster_placement_group_id = var.cluster_placement_group_id
  compartment_id             = var.compartment_id
  compute_count              = var.compute_count
  dynamic "customer_contacts" {
    for_each = var.customer_contacts
    content {
      email = customer_contacts.value.email
    }
  }
  defined_tags  = local.defined_tags
  display_name  = var.display_name
  freeform_tags = var.freeform_tags
  dynamic "maintenance_window" {
    for_each = var.maintenance_window != null ? [var.maintenance_window] : []
    content {
      custom_action_timeout_in_mins = lookup(maintenance_window.value, "custom_action_timeout_in_mins", null)
      dynamic "days_of_week" {
        for_each = maintenance_window.value.days_of_week != null ? [maintenance_window.value.days_of_week] : []
        content {
          name = days_of_week.value.name
        }
      }
      hours_of_day                     = lookup(maintenance_window.value, "hours_of_day", null)
      is_custom_action_timeout_enabled = lookup(maintenance_window.value, "is_custom_action_timeout_enabled", null)
      is_monthly_patching_enabled      = lookup(maintenance_window.value, "is_monthly_patching_enabled", null)
      lead_time_in_weeks               = lookup(maintenance_window.value, "lead_time_in_weeks", null)
      dynamic "months" {
        for_each = maintenance_window.value.months != null ? [maintenance_window.value.months] : []
        content {
          name = months.value.name
        }
      }
      patching_mode  = lookup(maintenance_window.value, "patching_mode", null)
      preference     = lookup(maintenance_window.value, "preference", null)
      weeks_of_month = lookup(maintenance_window.value, "weeks_of_month", null)
    }
  }
  shape         = var.shape
  storage_count = var.storage_count
  lifecycle {
    ignore_changes = [
      defined_tags["IT.create_date"]
    ]
  }
  timeouts {
    create = "12h"
    delete = "6h"
  }
}

resource "oci_identity_policy" "exadata_cluster_infrastructure_policy" {
  #if you are deploying the resource outside your home region uncomment the line below
  #provider   = oci.oci-gru
  depends_on = [oci_database_cloud_exadata_infrastructure.exadata_infrastructure]
  for_each = {
    for group in var.groups : group => group
    if var.groups != [] && var.compartment != null
  }
  compartment_id = var.compartment_id
  name           = "policy_${var.display_name}"
  description    = "allow one or more groups to read the exadata infrastructure"
  statements = [
    "Allow group ${each.value} to read exadata-infrastructures in compartment ${var.compartment}"
  ]
}