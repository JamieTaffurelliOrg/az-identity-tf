locals {
  service_principal_admin_consents = distinct(flatten([
    for service_principal in var.service_principals : [
      for admin_consent in service_principal.admin_consents : {
        service_principal_name = admin_consent.service_principal_name
        app_role_id            = admin_consent.app_role_id
        resource_object_id     = admin_consent.resource_object_id
      } if service_principal.admin_consents != null
  ] if var.service_principals != null]))
}
