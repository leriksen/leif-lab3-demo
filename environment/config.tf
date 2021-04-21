module "globals" {
  source = "../config/global"
}

module "subscription" {
  source       = "../config/subscription"
  subscription = module.globals.subscription_mapping[var.WORKSPACE]
}

module "environment" {
  source = "../config/environment"
  environment = var.WORKSPACE
}

