resource "azurerm_key_vault" "akv" {
  location            = module.subscription.location
  name                = "vcs-lab3-${var.TF_WORKSPACE}"
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = module.environment.key_vault_sku
  tenant_id           = module.globals.tenant_id
  tags                = local.tags
}