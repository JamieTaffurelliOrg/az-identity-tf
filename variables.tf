variable "applications" {
  type = map(object(
    {
      display_name                   = string
      device_only_auth_enabled       = optional(bool, false)
      fallback_public_client_enabled = optional(bool, false)
      identifier_uris                = optional(list(string))
      logo_image                     = optional(string)
      marketing_uri                  = optional(string)
      owners                         = optional(list(string))
      prevent_duplicate_name         = optional(bool, true)
      privacy_statement_uri          = optional(string)
      sign_in_audience               = optional(string, "AzureADMyOrg")
      support_url                    = optional(string)
      terms_of_service_url           = optional(string)
      tags                           = list(string)
    }
  ))
  default     = {}
  description = "The Azure AD applications to create"
}

variable "application_federated_identity_credentials" {
  type = map(object(
    {
      display_name             = string
      application_id_reference = string
      description              = string
      audiences                = optional(list(string), ["api://AzureADTokenExchange"])
      issuer                   = string
      subject                  = string
    }
  ))
  default     = {}
  description = "The OpenID Connect credentials to add to Azure AD applications"
}

variable "service_principals" {
  type = map(object(
    {
      account_enabled              = optional(bool, true)
      alternative_names            = optional(list(string), [])
      app_role_assignment_required = optional(bool, false)
      application_id_reference     = string
      description                  = string
      login_url                    = optional(string)
      notes                        = optional(string)
      notification_email_addresses = optional(list(string), [])
      owners                       = optional(list(string))
      use_existing                 = optional(bool, false)
      tags                         = list(string)
    }
  ))
  default     = {}
  description = "The Azure AD service principals to create"
}

variable "users" {
  type = map(object(
    {
      user_principal_name  = string
      display_name         = string
      account_enabled      = optional(bool, true)
      business_phones      = optional(string)
      city                 = optional(string)
      company_name         = optional(string)
      cost_center          = optional(string)
      country              = optional(string)
      department           = optional(string)
      division             = optional(string)
      employee_id          = optional(string)
      employee_type        = optional(string)
      fax_number           = optional(string)
      given_name           = optional(string)
      job_title            = optional(string)
      mail                 = optional(string)
      mobile_phone         = optional(string)
      office_location      = optional(string)
      other_mails          = optional(list(string))
      postal_code          = optional(string)
      preffered_language   = optional(string)
      show_in_address_list = optional(bool, true)
      state                = optional(string)
      street_address       = optional(string)
      surname              = optional(string)
      usage_location       = optional(string)
    }
  ))
  default     = {}
  description = "The Azure AD users to create"
}

variable "groups" {
  type = map(object(
    {
      display_name           = string
      assisgnable_to_role    = optional(bool, true)
      description            = string
      owners                 = optional(list(string))
      prevent_duplicate_name = optional(bool, true)
      security_enabled       = optional(bool, true)
    }
  ))
  default     = {}
  description = "The Azure AD groups to create"
}

variable "group_memberships_users" {
  type = map(object(
    {
      group_reference  = string
      member_reference = string
    }
  ))
  default     = {}
  description = "The group memberships of Azure AD users"
}

variable "group_memberships_service_principals" {
  type = map(object(
    {
      group_reference  = string
      member_reference = string
    }
  ))
  default     = {}
  description = "The group memberships of Azure AD service principals"
}

variable "group_memberships_groups" {
  type = map(object(
    {
      group_reference  = string
      member_reference = string
    }
  ))
  default     = {}
  description = "The group memberships of Azure AD groups"
}

variable "registered_roles" {
  type        = list(string)
  description = "The Azure AD roles to register for role assignments"
  default     = []
}

variable "role_assignments_users" {
  type = map(object(
    {
      user_reference = string
      template_id    = string
    }
  ))
  default     = {}
  description = "The role assignments to give to users"
}

variable "role_assignments_service_principals" {
  type = map(object(
    {
      service_principal_reference = string
      template_id                 = string
    }
  ))
  default     = {}
  description = "The role assignments to give to service principals"
}

variable "role_assignments_groups" {
  type = map(object(
    {
      group_reference = string
      template_id     = string
    }
  ))
  default     = {}
  description = "The role assignments to give to groups"
}

variable "rbac_role_assignments_users" {
  type = map(object(
    {
      user_reference       = string
      role_definition_name = string
      scope                = string
      description          = optional(string)
    }
  ))
  default     = {}
  description = "The RBAC role assignments to give to users"
}

variable "rbac_role_assignments_service_principals" {
  type = map(object(
    {
      service_principal_reference = string
      role_definition_name        = string
      scope                       = string
      description                 = optional(string)
    }
  ))
  default     = {}
  description = "The RBAC role assignments to give to service principals"
}

variable "rbac_role_assignments_groups" {
  type = map(object(
    {
      group_reference      = string
      role_definition_name = string
      scope                = string
      description          = optional(string)
    }
  ))
  default     = {}
  description = "The RBAC role assignments to give to groups"
}

variable "rbac_role_definitions" {
  type = list(object(
    {
      name              = string
      scope             = string
      description       = string
      actions           = optional(list(string), [])
      not_actions       = optional(list(string), [])
      data_actions      = optional(list(string), [])
      not_data_actions  = optional(list(string), [])
      assignable_scopes = list(string)
    }
  ))
  default     = []
  description = "The custom RBAC role defintions to create to groups"
}
