/*

This resource create a "pseudo-unique" random string to be appended to each resource name to avoid conflicts if
this plan is applied multiple time to the same namespace.

*/
resource "random_id" "unique_id" {
  byte_length = 4
}

data "template_file" "unique_id" {
  template = "${var.deployment_identifier} (${random_id.unique_id.hex})"
}

resource "random_id" "postgres_password" {
  byte_length = 32
}
