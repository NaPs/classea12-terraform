resource "openstack_networking_secgroup_v2" "secgroup_server" {
  name = "Peertube Server ${data.template_file.unique_id.rendered}"
}

resource "openstack_networking_secgroup_rule_v2" "secgroup_rule_full_access" {
  direction  = "ingress"
  ethertype = "IPv4"
  protocol = ""
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.secgroup_server.id}"
}
