module "globals" {
  source = "../config/global"
}

module "subscription" {
  source       = "../config/subscription"
  subscription = module.globals.subscription_mapping[var.TF_WORKSPACE]
}

module "environment" {
  source = "../config/environment"
  environment = var.TF_WORKSPACE
}

