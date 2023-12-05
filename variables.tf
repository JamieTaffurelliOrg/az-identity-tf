variable "applications" {
  type = map(object(
    {
      display_name                   = string
      device_only_auth_enabled       = optional(bool, false)
      fallback_public_client_enabled = optional(bool, false)
      identifier_uris                = optional(list(string), [])
      logo_image                     = optional(string)
      marketing_uri                  = optional(string)
      owners                         = optional(list(string))
      prevent_duplicate_name         = optional(bool, true)
      privacy_statement_uri          = optional(string)
      sign_in_audience               = optional(string, "AzureADMyOrg")
      support_url                    = optional(string)
      terms_of_service_url           = optional(string)
      required_resource_accesses = optional(list(object(
        {
          resource_app_id = string
          resource_accesses = list(object(
            {
              id   = string
              type = string
            }
          ))
        }
      )), [])
      tags = list(string)
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
      alternative_names            = optional(list(string))
      app_role_assignment_required = optional(bool, false)
      application_id_reference     = string
      description                  = string
      login_url                    = optional(string)
      notes                        = optional(string)
      notification_email_addresses = optional(list(string))
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
      business_phones      = optional(list(string))
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
      assignable_to_role     = optional(bool, true)
      description            = string
      owners                 = optional(list(string))
      prevent_duplicate_name = optional(bool, true)
      security_enabled       = optional(bool, true)
    }
  ))
  default     = {}
  description = "The Azure AD groups to create"
}

variable "objects" {
  type = map(object(
    {
      object_id = string
    }
  ))
  default     = {}
  description = "Azure AD objects created outside of the calling configuration that require role assignments"
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

variable "group_memberships_objects" {
  type = map(object(
    {
      group_reference  = string
      member_reference = string
    }
  ))
  default     = {}
  description = "The group memberships of Azure AD objects"
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

variable "role_assignments_objects" {
  type = map(object(
    {
      object_reference = string
      template_id      = string
    }
  ))
  default     = {}
  description = "The role assignments to give to objects"
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

variable "rbac_role_assignments_objects" {
  type = map(object(
    {
      object_reference     = string
      role_definition_name = string
      scope                = string
      description          = optional(string)
    }
  ))
  default     = {}
  description = "The RBAC role assignments to give to objects"
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

variable "custom_rbac_role_assignments_users" {
  type = map(object(
    {
      user_reference        = string
      custom_role_reference = optional(string)
      custom_role_id        = optional(string)
      scope                 = string
      description           = optional(string)
    }
  ))
  default     = {}
  description = "The RBAC role assignments to give to users for custom role definitions"
}

variable "custom_rbac_role_assignments_service_principals" {
  type = map(object(
    {
      service_principal_reference = string
      custom_role_reference       = optional(string)
      custom_role_id              = optional(string)
      scope                       = string
      description                 = optional(string)
    }
  ))
  default     = {}
  description = "The RBAC role assignments to give to service principals for custom role definitions"
}

variable "custom_rbac_role_assignments_groups" {
  type = map(object(
    {
      group_reference       = string
      custom_role_reference = optional(string)
      custom_role_id        = optional(string)
      scope                 = string
      description           = optional(string)
    }
  ))
  default     = {}
  description = "The RBAC role assignments to give to groups for custom role definitions"
}

variable "custom_rbac_role_assignments_objects" {
  type = map(object(
    {
      object_reference      = string
      custom_role_reference = optional(string)
      custom_role_id        = optional(string)
      scope                 = string
      description           = optional(string)
    }
  ))
  default     = {}
  description = "The RBAC role assignments to give to objects for custom role definitions"
}

variable "pim_assignments_groups" {
  type = list(object(
    {
      management_group_id = string
      location            = string
      scope               = string
      group_reference     = string
      role_definition_id  = string
      request_type        = optional(string, "AdminUpdate")
      justification       = string
      duration            = optional(string)
      end_date_time       = optional(string)
      type                = optional(string, "NoExpiration")
      start_date_time     = optional(string)
      deploy              = bool
    }
  ))
  default     = []
  description = "The PIM assignments to give to Azure AD groups"
}

variable "named_locations" {
  type = list(object(
    {
      name = string
      ip_locations = optional(map(object({
        ip_ranges = list(string)
        trusted   = optional(bool, true)
      })))
      country_locations = optional(map(object({
        countries_and_regions                 = list(string)
        include_unknown_countries_and_regions = optional(bool, false)
      })))
    }
  ))
  default     = []
  description = "Named locations to include for Conditional Access Policies"
}

variable "conditional_access_policies" {
  type = list(object(
    {
      name                = string
      state               = optional(string, "enabled")
      client_app_types    = optional(list(string), ["all"])
      sign_in_risk_levels = optional(list(string))
      user_risk_levels    = optional(list(string))
      applications = object({
        included_applications = optional(list(string))
        excluded_applications = optional(list(string))
        included_user_actions = optional(list(string))
      })
      devices = optional(object({
        mode = string
        rule = string
      }))
      locations = object({
        excluded_location_references = optional(list(string), [])
        excluded_location_ids        = optional(list(string), [])
        included_location_references = optional(list(string), [])
        included_location_ids        = optional(list(string), [])
      })
      platforms = object({
        excluded_platforms = optional(list(string))
        included_platforms = list(string)
      })
      users = object({
        included_user_ids         = optional(list(string), [])
        included_user_references  = optional(list(string), [])
        excluded_user_ids         = optional(list(string), [])
        excluded_user_references  = optional(list(string), [])
        included_group_ids        = optional(list(string), [])
        included_group_references = optional(list(string), [])
        excluded_group_ids        = optional(list(string), [])
        excluded_group_references = optional(list(string), [])
        included_role_ids         = optional(list(string), [])
        excluded_role_ids         = optional(list(string), [])
      })
      grant_controls = object({
        operator                      = string
        built_in_controls             = list(string)
        custom_authentication_factors = optional(list(string))
        terms_of_use                  = optional(list(string))
      })
      session_controls = optional(object({
        application_enforced_restrictions_enabled = optional(bool, false)
        cloud_app_security_policy                 = optional(string)
        persistent_browser_mode                   = optional(string)
        sign_in_frequency                         = optional(number)
        sign_in_frequency_period                  = optional(string)
      }))
    }
  ))
  default     = []
  description = "Named locations to include for Conditional Access Policies"
}

variable "log_analytics_workspace" {
  type = object(
    {
      name                = optional(string)
      resource_group_name = optional(string)
    }
  )
  default     = {}
  description = "The existing log analytics workspaces to send diagnostic logs to"
}
