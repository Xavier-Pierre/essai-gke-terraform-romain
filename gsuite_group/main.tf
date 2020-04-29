provider "gsuite" {
  impersonated_user_email = "cto@quelleenergie.fr"

  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.group",
    "https://www.googleapis.com/auth/admin.directory.user",
    "https://www.googleapis.com/auth/apps.groups.settings",
  ]
}

resource "gsuite_group" "group" {
  email       = "${format("%s@effy.fr", var.group_name)}"
  name        = "${var.group_name}"
  description = "${var.group_description}"
}

resource "gsuite_group_settings" "settings" {
  email = "${gsuite_group.group.email}"

  allow_external_members        = "false"
  allow_web_posting             = "false"
  include_custom_footer         = "false"
  members_can_post_as_the_group = "false"
  who_can_approve_members       = "ALL_MANAGERS_CAN_APPROVE"
  who_can_contact_owner         = "ALL_MANAGERS_CAN_CONTACT"
  who_can_join                  = "INVITED_CAN_JOIN"
  who_can_moderate_members      = "OWNERS_AND_MANAGERS"
  who_can_post_message          = "ALL_MANAGERS_CAN_POST"
  who_can_view_group            = "ALL_MANAGERS_CAN_VIEW"
  who_can_view_membership       = "ALL_MANAGERS_CAN_VIEW"

  depends_on = ["gsuite_group.group"]
}
