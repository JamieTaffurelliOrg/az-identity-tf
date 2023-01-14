resource "azuread_application" "applications" {
  for_each                       = { for k, v in var.applications : k => v if k != null }
  display_name                   = each.value["display_name"]
  device_only_auth_enabled       = each.value["device_only_auth_enabled"]
  fallback_public_client_enabled = each.value["fallback_public_client_enabled"]
  identifier_uris                = each.value["identifier_uris"]
  logo_image                     = each.value["logo_image"]
  marketing_url                  = each.value["marketing_uri"]
  owners                         = each.value["owners"] == null ? [data.azuread_client_config.current.object_id] : each.value["owners"]
  prevent_duplicate_names        = each.value["prevent_duplicate_name"]
  privacy_statement_url          = each.value["privacy_statement_uri"]
  sign_in_audience               = each.value["sign_in_audience"]
  support_url                    = each.value["support_url"]
  terms_of_service_url           = each.value["terms_of_service_url"]
  tags                           = each.value["tags"]
}

resource "azuread_application_federated_identity_credential" "federated_identity_credentials" {
  for_each              = { for k, v in var.application_federated_identity_credentials : k => v if k != null }
  application_object_id = azuread_application.applications[(each.value["application_id_reference"])].object_id
  display_name          = each.value["display_name"]
  description           = each.value["description"]
  audiences             = each.value["audiences"]
  issuer                = each.value["issuer"]
  subject               = each.value["subject"]
}

resource "azuread_service_principal" "service_principals" {
  for_each                     = { for k, v in var.service_principals : k => v if k != null }
  account_enabled              = each.value["account_enabled"]
  alternative_names            = each.value["alternative_names"]
  app_role_assignment_required = each.value["app_role_assignment_required"]
  application_id               = azuread_application.applications[(each.value["application_id_reference"])].application_id
  description                  = each.value["description"]
  login_url                    = each.value["login_url"]
  notes                        = each.value["notes"]
  notification_email_addresses = each.value["notification_email_addresses"]
  owners                       = each.value["owners"] == null ? [data.azuread_client_config.current.object_id] : each.value["owners"]
  use_existing                 = each.value["use_existing"]
  tags                         = each.value["tags"]
}

resource "random_password" "user_password" {
  for_each         = var.users
  length           = 16
  special          = true
  lower            = true
  numeric          = true
  min_numeric      = 1
  min_special      = 1
  min_upper        = 1
  override_special = "!^(){}[]-_=+"
}

resource "azuread_user" "users" {
  for_each                    = { for k, v in var.users : k => v if k != null }
  user_principal_name         = each.value["user_principal_name"]
  display_name                = each.value["display_name"]
  account_enabled             = each.value["account_enabled"]
  business_phones             = each.value["business_phones"]
  city                        = each.value["city"]
  company_name                = each.value["company_name"]
  cost_center                 = each.value["cost_center"]
  country                     = each.value["country"]
  department                  = each.value["department"]
  division                    = each.value["division"]
  employee_id                 = each.value["employee_id"]
  employee_type               = each.value["employee_type"]
  fax_number                  = each.value["fax_number"]
  given_name                  = each.value["given_name"]
  job_title                   = each.value["job_title"]
  mail                        = each.value["mail"]
  mobile_phone                = each.value["mobile_phone"]
  office_location             = each.value["office_location"]
  other_mails                 = each.value["other_mails"]
  postal_code                 = each.value["postal_code"]
  preferred_language          = each.value["preffered_language"]
  show_in_address_list        = each.value["show_in_address_list"]
  state                       = each.value["state"]
  street_address              = each.value["street_address"]
  surname                     = each.value["surname"]
  usage_location              = each.value["usage_location"]
  disable_password_expiration = false
  disable_strong_password     = false
  force_password_change       = true
  password                    = random_password.user_password[(each.key)].result

  lifecycle {
    ignore_changes = [
      password
    ]
  }
}

resource "azuread_group" "groups" {
  for_each                = { for k, v in var.groups : k => v if k != null }
  display_name            = each.value["display_name"]
  assignable_to_role      = each.value["assisgnable_to_role"]
  description             = each.value["description"]
  owners                  = each.value["owners"] == null ? [data.azuread_client_config.current.object_id] : each.value["owners"]
  prevent_duplicate_names = each.value["prevent_duplicate_name"]
  security_enabled        = each.value["security_enabled"]
}

resource "azuread_group_member" "group_members_users" {
  for_each         = { for k, v in var.group_memberships_users : k => v if k != null }
  group_object_id  = azuread_group.groups[(each.value["group_reference"])].object_id
  member_object_id = azuread_user.users[(each.value["member_reference"])].object_id
}

resource "azuread_group_member" "group_members_service_principals" {
  for_each         = { for k, v in var.group_memberships_service_principals : k => v if k != null }
  group_object_id  = azuread_group.groups[(each.value["group_reference"])].object_id
  member_object_id = azuread_service_principal.service_principals[(each.value["member_reference"])].object_id
}

resource "azuread_group_member" "group_members_groups" {
  for_each         = { for k, v in var.group_memberships_groups : k => v if k != null }
  group_object_id  = azuread_group.groups[(each.value["group_reference"])].object_id
  member_object_id = azuread_group.groups[(each.value["object_reference"])].object_id
}

resource "azuread_group_member" "group_members_objects" {
  for_each         = { for k, v in var.group_memberships_objects : k => v if k != null }
  group_object_id  = azuread_group.groups[(each.value["group_reference"])].object_id
  member_object_id = var.objects[(each.value["object_reference"])].object_id
}

resource "azuread_directory_role" "roles" {
  for_each     = { for k in var.registered_roles : k => k if k != null }
  display_name = each.value
}

resource "azuread_directory_role_assignment" "role_assignments_users" {
  for_each            = { for k, v in var.role_assignments_users : k => v if k != null }
  role_id             = each.value["template_id"]
  principal_object_id = azuread_user.users[(each.value["user_reference"])].object_id
}

resource "azuread_directory_role_assignment" "role_assignments_service_principals" {
  for_each            = { for k, v in var.role_assignments_service_principals : k => v if k != null }
  role_id             = each.value["template_id"]
  principal_object_id = azuread_service_principal.service_principals[(each.value["service_principal_reference"])].object_id
}

resource "azuread_directory_role_assignment" "role_assignments_groups" {
  for_each            = { for k, v in var.role_assignments_groups : k => v if k != null }
  role_id             = each.value["template_id"]
  principal_object_id = azuread_group.groups[(each.value["group_reference"])].object_id
}

resource "azuread_directory_role_assignment" "role_assignments_objects" {
  for_each            = { for k, v in var.role_assignments_objects : k => v if k != null }
  role_id             = each.value["template_id"]
  principal_object_id = var.objects[(each.value["object_reference"])].object_id
}

resource "azurerm_role_assignment" "rbac_role_assignments_users" {
  for_each             = { for k, v in var.rbac_role_assignments_users : k => v if k != null }
  scope                = each.value["scope"]
  role_definition_name = each.value["role_definition_name"]
  principal_id         = azuread_user.users[(each.value["user_reference"])].object_id
}

resource "azurerm_role_assignment" "rbac_role_assignments_service_principals" {
  for_each             = { for k, v in var.rbac_role_assignments_service_principals : k => v if k != null }
  scope                = each.value["scope"]
  role_definition_name = each.value["role_definition_name"]
  principal_id         = azuread_service_principal.service_principals[(each.value["service_principal_reference"])].object_id
}

resource "azurerm_role_assignment" "rbac_role_assignments_groups" {
  for_each             = { for k, v in var.rbac_role_assignments_groups : k => v if k != null }
  scope                = each.value["scope"]
  role_definition_name = each.value["role_definition_name"]
  principal_id         = azuread_group.groups[(each.value["group_reference"])].object_id
}

resource "azurerm_role_assignment" "rbac_role_assignments_objects" {
  for_each             = { for k, v in var.rbac_role_assignments_objects : k => v if k != null }
  scope                = each.value["scope"]
  role_definition_name = each.value["role_definition_name"]
  principal_id         = var.objects[(each.value["object_reference"])].object_id
}

resource "azurerm_role_definition" "rbac_role_definitions" {
  for_each    = { for k in var.rbac_role_definitions : k.name => k }
  name        = each.key
  scope       = each.value["scope"]
  description = each.value["description"]

  permissions {
    actions          = each.value["actions"]
    not_actions      = each.value["not_actions"]
    data_actions     = each.value["data_actions"]
    not_data_actions = each.value["not_data_actions"]
  }

  assignable_scopes = each.value["assignable_scopes"]
}

resource "azurerm_role_assignment" "custom_rbac_role_assignments_users" {
  for_each           = { for k, v in var.custom_rbac_role_assignments_users : k => v if k != null }
  scope              = each.value["scope"]
  role_definition_id = azurerm_role_definition.rbac_role_definitions[(each.value["custom_role_reference"])].role_definition_resource_id
  principal_id       = azuread_user.users[(each.value["user_reference"])].object_id
}

resource "azurerm_role_assignment" "custom_rbac_role_assignments_service_principals" {
  for_each           = { for k, v in var.custom_rbac_role_assignments_service_principals : k => v if k != null }
  scope              = each.value["scope"]
  role_definition_id = azurerm_role_definition.rbac_role_definitions[(each.value["custom_role_reference"])].role_definition_resource_id
  principal_id       = azuread_service_principal.service_principals[(each.value["service_principal_reference"])].object_id
}

resource "azurerm_role_assignment" "custom_rbac_role_assignments_groups" {
  for_each           = { for k, v in var.custom_rbac_role_assignments_groups : k => v if k != null }
  scope              = each.value["scope"]
  role_definition_id = azurerm_role_definition.rbac_role_definitions[(each.value["custom_role_reference"])].role_definition_resource_id
  principal_id       = azuread_group.groups[(each.value["group_reference"])].object_id
}

resource "azurerm_role_assignment" "custom_rbac_role_assignments_objects" {
  for_each           = { for k, v in var.custom_rbac_role_assignments_objects : k => v if k != null }
  scope              = each.value["scope"]
  role_definition_id = azurerm_role_definition.rbac_role_definitions[(each.value["custom_role_reference"])].role_definition_resource_id
  principal_id       = var.objects[(each.value["object_reference"])].object_id
}

resource "azurerm_monitor_aad_diagnostic_setting" "aad_diagnostics" {
  name                       = "${var.log_analytics_workspace.name}-security-logging"
  log_analytics_workspace_id = data.azurerm_log_analytics_workspace.logs.id

  log {
    category = "SignInLogs"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 365
    }
  }
  log {
    category = "AuditLogs"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 365
    }
  }
  log {
    category = "NonInteractiveUserSignInLogs"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 365
    }
  }
  log {
    category = "ServicePrincipalSignInLogs"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 365
    }
  }
  log {
    category = "ManagedIdentitySignInLogs"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 365
    }
  }
  log {
    category = "ProvisioningLogs"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 365
    }
  }
  log {
    category = "ADFSSignInLogs"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 365
    }
  }

  log {
    category = "RiskyUsers"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 365
    }
  }

  log {
    category = "UserRiskEvents"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 365
    }
  }

  log {
    category = "NetworkAccessTrafficLogs"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 365
    }
  }

  log {
    category = "RiskyServicePrincipals"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 365
    }
  }

  log {
    category = "ServicePrincipalRiskEvents"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 365
    }
  }

  log {
    category = "B2CRequestLogs"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 365
    }
  }

  log {
    category = "EnrichedOffice365AuditLogs"
    enabled  = true

    retention_policy {
      enabled = true
      days    = 365
    }
  }
}
