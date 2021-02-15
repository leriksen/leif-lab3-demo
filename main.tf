######### TERRAFORM BACKEND ##########
terraform {
  required_version = ">= 0.14"
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
  subscription = module.globals.subscription_mapping[var.TF_WORKSPACE]
}

module "environment" {
  source = "./modules/constants/environment"
  environment = var.TF_WORKSPACE
}

######### LOCALS #########
locals {
  tags = merge(
    module.globals.tags,
    {
      environment = var.TF_WORKSPACE
    }
  )
}
######### RESOURCES #########
resource "azurerm_resource_group" "rg" {
  name     = "lab3-demo-${var.TF_WORKSPACE}"
  location = module.subscription.location
  tags     = local.tags
}

resource "azurerm_key_vault" "akv" {
  location            = module.subscription.location
  name                = "vcs-lab3-${var.TF_WORKSPACE}"
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = module.environment.key_vault_sku
  tenant_id           = module.globals.tenant_id
  tags                = local.tags
}

######### OUTPUTS #########
output "TF_WORKSPACE" {
  value = var.TF_WORKSPACE
}

output "terraform_dot_workspace" {
  value = terraform.workspace
}