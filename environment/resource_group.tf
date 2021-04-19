module "resource_group" {
  source   = "../modules/resource_group"
  name     = "lab3-demo-${var.TF_WORKSPACE}"
  location = module.subscription.location
  tags     = local.tags
}
