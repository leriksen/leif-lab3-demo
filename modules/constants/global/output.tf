output "tenant_id" {
  value = "74f9ac2f-c1d2-412f-8435-6e60efdad5e1"
}

output "subscription_mapping" {
  value = {
    dev = "staging"
    tst = "staging"
    prd = "production"
  }
}

output "tags" {
  value = {
    project = "lab3"
  }
}