module "key_vault" {
  source              = "../modules/key_vault"
  location            = module.subscription.location
  name                = "vcs-lab3-${var.WORKSPACE}"
  resource_group_name = module.resource_group.name
  sku_name            = module.environment.key_vault_sku
  tenant_id           = module.globals.tenant_id
  tags                = local.tags
}