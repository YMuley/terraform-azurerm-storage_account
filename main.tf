
# --------- Storage Accounts ------------
resource "azurerm_storage_account" "storage_account" {
  for_each                      = local.storage_account
  name                          = each.value.name
  resource_group_name           = var.resource_group_output[each.value.resource_group_name].name
  location                      = each.value.location == null ? var.default_values.location : each.value.location
  account_tier                  = each.value.account_tier == null ? "Cold" : each.value.account_tier
  enable_https_traffic_only     = each.value.allow_https_only == null ? true : each.value.allow_https_only
  min_tls_version               = each.value.minimum_tls_version == null ? "TLS1_2" : each.value.minimum_tls_version
  shared_access_key_enabled     = each.value.shared_access_key_enabled //has to be false if storage account is access using active directory access
  account_replication_type      = each.value.account_replication_type
  public_network_access_enabled = each.value.public_network_access_enabled == null ? true : each.value.public_network_access_enabled
  dynamic "network_rules" {
    for_each = each.value.network_rules
    content {
      default_action             = network_rules.value.default_action == null ? "Allow" : "Deny"
      bypass                     = network_rules.value.bypass
      ip_rules                   = network_rules.value.ip_rules
      virtual_network_subnet_ids = [var.subnet_output[format("%s/%s", network_rules.value.virtual_network_name, network_rules.value.subnet_name)].id]
    }
  }
  tags = each.value.tags == null ? var.default_values.tags : each.value.tags
}
