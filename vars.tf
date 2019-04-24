variable "openstack_username" {
  type = "string"
}

variable "openstack_tenant" {
  type = "string"
}

variable "openstack_password" {
  type = "string"
}

variable "openstack_authurl" {
  type = "string"
  default = "https://identity.api.r1.nxs.enix.io/v3"
}

variable "deployment_identifier" {
  type = "string"
}

variable "public_address" {
  type = "string"
}
