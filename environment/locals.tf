locals {
  tags = merge(
    module.globals.tags,
    {
      environment = var.TF_WORKSPACE
    }
  )
}
