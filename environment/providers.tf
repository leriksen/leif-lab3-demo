provider "azurerm" {
  tenant_id       = module.globals.tenant_id
  subscription_id = module.subscription.subscription_id
  features {}
}
