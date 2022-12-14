# az-identity-tf
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 2.30 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.20 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | ~> 2.30 |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~> 3.20 |
| <a name="provider_azurerm.logs"></a> [azurerm.logs](#provider\_azurerm.logs) | ~> 3.20 |
| <a name="provider_random"></a> [random](#provider\_random) | ~> 3.4 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuread_application.applications](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application) | resource |
| [azuread_application_federated_identity_credential.federated_identity_credentials](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_federated_identity_credential) | resource |
| [azuread_directory_role.roles](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/directory_role) | resource |
| [azuread_directory_role_assignment.role_assignments_groups](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/directory_role_assignment) | resource |
| [azuread_directory_role_assignment.role_assignments_service_principals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/directory_role_assignment) | resource |
| [azuread_directory_role_assignment.role_assignments_users](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/directory_role_assignment) | resource |
| [azuread_group.groups](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group) | resource |
| [azuread_group_member.group_members_groups](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_group_member.group_members_service_principals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_group_member.group_members_users](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/group_member) | resource |
| [azuread_service_principal.service_principals](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal) | resource |
| [azuread_user.users](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/user) | resource |
| [azurerm_monitor_aad_diagnostic_setting.aad_diagnostics](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_aad_diagnostic_setting) | resource |
| [azurerm_role_assignment.custom_rbac_role_assignments_groups](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.custom_rbac_role_assignments_service_principals](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.custom_rbac_role_assignments_users](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.rbac_role_assignments_groups](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.rbac_role_assignments_service_principals](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.rbac_role_assignments_users](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_definition.rbac_role_definitions](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition) | resource |
| [random_password.user_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [azuread_client_config.current](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/client_config) | data source |
| [azurerm_log_analytics_workspace.logs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/log_analytics_workspace) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application_federated_identity_credentials"></a> [application\_federated\_identity\_credentials](#input\_application\_federated\_identity\_credentials) | The OpenID Connect credentials to add to Azure AD applications | <pre>map(object(<br>    {<br>      display_name             = string<br>      application_id_reference = string<br>      description              = string<br>      audiences                = optional(list(string), ["api://AzureADTokenExchange"])<br>      issuer                   = string<br>      subject                  = string<br>    }<br>  ))</pre> | `{}` | no |
| <a name="input_applications"></a> [applications](#input\_applications) | The Azure AD applications to create | <pre>map(object(<br>    {<br>      display_name                   = string<br>      device_only_auth_enabled       = optional(bool, false)<br>      fallback_public_client_enabled = optional(bool, false)<br>      identifier_uris                = optional(list(string), [])<br>      logo_image                     = optional(string)<br>      marketing_uri                  = optional(string)<br>      owners                         = optional(list(string))<br>      prevent_duplicate_name         = optional(bool, true)<br>      privacy_statement_uri          = optional(string)<br>      sign_in_audience               = optional(string, "AzureADMyOrg")<br>      support_url                    = optional(string)<br>      terms_of_service_url           = optional(string)<br>      tags                           = list(string)<br>    }<br>  ))</pre> | `{}` | no |
| <a name="input_custom_rbac_role_assignments_groups"></a> [custom\_rbac\_role\_assignments\_groups](#input\_custom\_rbac\_role\_assignments\_groups) | The RBAC role assignments to give to groups for custom role definitions | <pre>map(object(<br>    {<br>      group_reference       = string<br>      custom_role_reference = string<br>      scope                 = string<br>      description           = optional(string)<br>    }<br>  ))</pre> | `{}` | no |
| <a name="input_custom_rbac_role_assignments_service_principals"></a> [custom\_rbac\_role\_assignments\_service\_principals](#input\_custom\_rbac\_role\_assignments\_service\_principals) | The RBAC role assignments to give to service principals for custom role definitions | <pre>map(object(<br>    {<br>      service_principal_reference = string<br>      custom_role_reference       = string<br>      scope                       = string<br>      description                 = optional(string)<br>    }<br>  ))</pre> | `{}` | no |
| <a name="input_custom_rbac_role_assignments_users"></a> [custom\_rbac\_role\_assignments\_users](#input\_custom\_rbac\_role\_assignments\_users) | The RBAC role assignments to give to users for custom role definitions | <pre>map(object(<br>    {<br>      user_reference        = string<br>      custom_role_reference = string<br>      scope                 = string<br>      description           = optional(string)<br>    }<br>  ))</pre> | `{}` | no |
| <a name="input_group_memberships_groups"></a> [group\_memberships\_groups](#input\_group\_memberships\_groups) | The group memberships of Azure AD groups | <pre>map(object(<br>    {<br>      group_reference  = string<br>      member_reference = string<br>    }<br>  ))</pre> | `{}` | no |
| <a name="input_group_memberships_service_principals"></a> [group\_memberships\_service\_principals](#input\_group\_memberships\_service\_principals) | The group memberships of Azure AD service principals | <pre>map(object(<br>    {<br>      group_reference  = string<br>      member_reference = string<br>    }<br>  ))</pre> | `{}` | no |
| <a name="input_group_memberships_users"></a> [group\_memberships\_users](#input\_group\_memberships\_users) | The group memberships of Azure AD users | <pre>map(object(<br>    {<br>      group_reference  = string<br>      member_reference = string<br>    }<br>  ))</pre> | `{}` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | The Azure AD groups to create | <pre>map(object(<br>    {<br>      display_name           = string<br>      assisgnable_to_role    = optional(bool, true)<br>      description            = string<br>      owners                 = optional(list(string))<br>      prevent_duplicate_name = optional(bool, true)<br>      security_enabled       = optional(bool, true)<br>    }<br>  ))</pre> | `{}` | no |
| <a name="input_log_analytics_workspace"></a> [log\_analytics\_workspace](#input\_log\_analytics\_workspace) | The existing log analytics workspaces to send diagnostic logs to | <pre>object(<br>    {<br>      name                = string<br>      resource_group_name = string<br>    }<br>  )</pre> | n/a | yes |
| <a name="input_rbac_role_assignments_groups"></a> [rbac\_role\_assignments\_groups](#input\_rbac\_role\_assignments\_groups) | The RBAC role assignments to give to groups | <pre>map(object(<br>    {<br>      group_reference      = string<br>      role_definition_name = string<br>      scope                = string<br>      description          = optional(string)<br>    }<br>  ))</pre> | `{}` | no |
| <a name="input_rbac_role_assignments_service_principals"></a> [rbac\_role\_assignments\_service\_principals](#input\_rbac\_role\_assignments\_service\_principals) | The RBAC role assignments to give to service principals | <pre>map(object(<br>    {<br>      service_principal_reference = string<br>      role_definition_name        = string<br>      scope                       = string<br>      description                 = optional(string)<br>    }<br>  ))</pre> | `{}` | no |
| <a name="input_rbac_role_assignments_users"></a> [rbac\_role\_assignments\_users](#input\_rbac\_role\_assignments\_users) | The RBAC role assignments to give to users | <pre>map(object(<br>    {<br>      user_reference       = string<br>      role_definition_name = string<br>      scope                = string<br>      description          = optional(string)<br>    }<br>  ))</pre> | `{}` | no |
| <a name="input_rbac_role_definitions"></a> [rbac\_role\_definitions](#input\_rbac\_role\_definitions) | The custom RBAC role defintions to create to groups | <pre>list(object(<br>    {<br>      name              = string<br>      scope             = string<br>      description       = string<br>      actions           = optional(list(string), [])<br>      not_actions       = optional(list(string), [])<br>      data_actions      = optional(list(string), [])<br>      not_data_actions  = optional(list(string), [])<br>      assignable_scopes = list(string)<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_registered_roles"></a> [registered\_roles](#input\_registered\_roles) | The Azure AD roles to register for role assignments | `list(string)` | `[]` | no |
| <a name="input_role_assignments_groups"></a> [role\_assignments\_groups](#input\_role\_assignments\_groups) | The role assignments to give to groups | <pre>map(object(<br>    {<br>      group_reference = string<br>      template_id     = string<br>    }<br>  ))</pre> | `{}` | no |
| <a name="input_role_assignments_service_principals"></a> [role\_assignments\_service\_principals](#input\_role\_assignments\_service\_principals) | The role assignments to give to service principals | <pre>map(object(<br>    {<br>      service_principal_reference = string<br>      template_id                 = string<br>    }<br>  ))</pre> | `{}` | no |
| <a name="input_role_assignments_users"></a> [role\_assignments\_users](#input\_role\_assignments\_users) | The role assignments to give to users | <pre>map(object(<br>    {<br>      user_reference = string<br>      template_id    = string<br>    }<br>  ))</pre> | `{}` | no |
| <a name="input_service_principals"></a> [service\_principals](#input\_service\_principals) | The Azure AD service principals to create | <pre>map(object(<br>    {<br>      account_enabled              = optional(bool, true)<br>      alternative_names            = optional(list(string))<br>      app_role_assignment_required = optional(bool, false)<br>      application_id_reference     = string<br>      description                  = string<br>      login_url                    = optional(string)<br>      notes                        = optional(string)<br>      notification_email_addresses = optional(list(string))<br>      owners                       = optional(list(string))<br>      use_existing                 = optional(bool, false)<br>      tags                         = list(string)<br>    }<br>  ))</pre> | `{}` | no |
| <a name="input_users"></a> [users](#input\_users) | The Azure AD users to create | <pre>map(object(<br>    {<br>      user_principal_name  = string<br>      display_name         = string<br>      account_enabled      = optional(bool, true)<br>      business_phones      = optional(string)<br>      city                 = optional(string)<br>      company_name         = optional(string)<br>      cost_center          = optional(string)<br>      country              = optional(string)<br>      department           = optional(string)<br>      division             = optional(string)<br>      employee_id          = optional(string)<br>      employee_type        = optional(string)<br>      fax_number           = optional(string)<br>      given_name           = optional(string)<br>      job_title            = optional(string)<br>      mail                 = optional(string)<br>      mobile_phone         = optional(string)<br>      office_location      = optional(string)<br>      other_mails          = optional(list(string))<br>      postal_code          = optional(string)<br>      preffered_language   = optional(string)<br>      show_in_address_list = optional(bool, true)<br>      state                = optional(string)<br>      street_address       = optional(string)<br>      surname              = optional(string)<br>      usage_location       = optional(string)<br>    }<br>  ))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_application_federated_identity_credentials"></a> [application\_federated\_identity\_credentials](#output\_application\_federated\_identity\_credentials) | Azure AD application federated identity credentials |
| <a name="output_applications"></a> [applications](#output\_applications) | Azure AD applications |
| <a name="output_groups"></a> [groups](#output\_groups) | Azure AD groups |
| <a name="output_rbac_role_definitions"></a> [rbac\_role\_definitions](#output\_rbac\_role\_definitions) | Azure Custom RBAC roles |
| <a name="output_service_principals"></a> [service\_principals](#output\_service\_principals) | Azure AD service principals |
| <a name="output_users"></a> [users](#output\_users) | Azure AD users |
<!-- END_TF_DOCS -->
