output "applications" {
  value       = [for applications in azuread_application.applications : applications]
  description = "Azure AD applications"
}

output "application_federated_identity_credentials" {
  value       = [for federated_identity_credential_id in azuread_application_federated_identity_credential.federated_identity_credentials : federated_identity_credential_id.credential_id]
  description = "Azure AD application federated identity credentials"
}

output "service_principals" {
  value       = [for service_principals in azuread_service_principal.service_principals : service_principals]
  description = "Azure AD service principals"
}

output "users" {
  value       = [for users in azuread_user.users : users]
  description = "Azure AD users"
  sensitive   = true
}

output "groups" {
  value       = [for groups in azuread_group.groups : groups]
  description = "Azure AD groups"
}

output "rbac_role_definitions" {
  value       = { for k, v in azurerm_role_definition.rbac_role_definitions : k => v }
  description = "Azure Custom RBAC roles"
}
