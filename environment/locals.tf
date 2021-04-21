locals {
  tags = merge(
    module.globals.tags,
    {
      environment = var.WORKSPACE
    }
  )
}
