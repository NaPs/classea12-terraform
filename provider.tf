provider "openstack" {
  user_name = "${var.openstack_username}"
  tenant_name = "${var.openstack_tenant}"
  domain_name = "Default"
  password  = "${var.openstack_password}"
  auth_url  = "${var.openstack_authurl}"
}
