resource "openstack_networking_network_v2" "net_internal" {
  name = "Internal ${data.template_file.unique_id.rendered}"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "subnet_internal" {
  name = "Internal subnet ${data.template_file.unique_id.rendered}"
  network_id = "${openstack_networking_network_v2.net_internal.id}"
  cidr = "192.168.0.0/24"
  ip_version = 4
  dns_nameservers = ["1.1.1.1", "1.0.0.1"]
}

resource "openstack_networking_router_v2" "router" {
  name = "Router ${data.template_file.unique_id.rendered}"
  admin_state_up = "true"
  external_network_id = "15f0c299-1f50-42a6-9aff-63ea5b75f3fc"
}

resource "openstack_networking_router_interface_v2" "router_iface_internal" {
  router_id = "${openstack_networking_router_v2.router.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet_internal.id}"
}
