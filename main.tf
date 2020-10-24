######### TERRAFORM BACKEND ##########
terraform {
  required_version = ">= 0.13, < 0.14"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "leif-lab3"

    workspaces {
      prefix = "lab3-demo-"
    }
  }
}

######### PROVIDERS ##########
provider "azurerm" {
  version         = "~>2.0"
  tenant_id       = module.globals.tenant_id
  subscription_id = module.subscription.subscription_id
  features {}
}

######### CONSTANTS #########
module "globals" {
  source = "./modules/constants/global"
}

module "subscription" {
  source       = "./modules/constants/subscription"
  subscription = module.globals.subscription_mapping[var.TERRAFORM_WORKSPACE]
}

######### RESOURCES #########
//resource "azurerm_resource_group" "rg" {
//  name     = "lab3-demo-${var.TERRAFORM_WORKSPACE}"
//  location = module.subscription.location
//}

######### OUTPUTS #########
output "workspace" {
  value = var.TERRAFORM_WORKSPACE
}
