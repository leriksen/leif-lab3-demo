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
  subscription = module.globals.subscription_mapping[var.TERRAFORM_WORKSPACE]
}

module "environment" {
  source = "./modules/constants/environment"
  environment = var.TERRAFORM_WORKSPACE
}

######### LOCALS #########
locals {
  tags = merge(
    module.globals.tags,
    {
      environment = var.TERRAFORM_WORKSPACE
    }
  )
}
######### RESOURCES #########
resource "azurerm_resource_group" "rg" {
  name     = "lab3-demo-${var.TERRAFORM_WORKSPACE}"
  location = module.subscription.location
  tags     = local.tags
}

resource "azurerm_key_vault" "akv" {
  location            = module.subscription.location
  name                = "v-lab3-${var.TERRAFORM_WORKSPACE}"
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = module.environment.key_vault_sku
  tenant_id           = module.globals.tenant_id
  tags                = local.tags
}

######### OUTPUTS #########
output "TERRAFORM_WORKSPACE" {
  value = var.TERRAFORM_WORKSPACE
}

output "tf_workspace" {
  value = terraform.workspace
}