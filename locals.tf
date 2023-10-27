
locals {   
    storage_account = {for storage_account in var.storage_account_list: storage_account.name => storage_account }     
}