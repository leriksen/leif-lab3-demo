output "subscription_id" {
  value = local.subscription_id[var.subscription]
}

output "subscription_name" {
  value = local.subscription_name[var.subscription]
}

output "location" {
  value = local.location[var.subscription]
}