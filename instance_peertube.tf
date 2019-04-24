resource "openstack_compute_floatingip_associate_v2" "associate_floatingip_peertube" {
  floating_ip = "${var.public_address}"
  instance_id = "${openstack_compute_instance_v2.instance_peertube.id}"
  fixed_ip = "${openstack_compute_instance_v2.instance_peertube.network.0.fixed_ip_v4}"
}

resource "openstack_compute_instance_v2" "instance_peertube" {
  name = "Peertube ${data.template_file.unique_id.rendered}"
  image_name = "Ubuntu 18.04.1 (Bionic Beaver)"
  flavor_name = "GP1.M"
  security_groups = ["${openstack_networking_secgroup_v2.secgroup_server.name}"]
  key_pair = "${openstack_compute_keypair_v2.ssh_deploy_key.name}"
  user_data = <<EOF
#cloud-config
packages:
- docker.io
- docker-compose
write_files:
- path: /peertube/docker-compose.yaml
  permissions: '0644'
  content: |
    ${indent(4, "${file("${path.module}/files/peertube/docker-compose.yaml")}")}
- path: /peertube/deployment.env
  permissions: '0644'
  content: |
    ${indent(4, "${data.template_file.peertube_environment.rendered}")}
- path: /peertube/nginx.conf
  permissions: '0644'
  content: |
    ${indent(4, "${file("${path.module}/files/peertube/nginx.conf")}")}
- path: /peertube/deploy.sh
  permissions: '0755'
  content: |
    ${indent(4, "${file("${path.module}/files/peertube/deploy.sh")}")}
- path: /etc/motd
  permissions: '0644'
  content: |
    ${indent(4, "${file("${path.module}/files/peertube/motd.txt")}")}
- path: /peertube/traefik/traefik.toml
  permissions: '0644'
  content: |
    ${indent(4, "${file("${path.module}/files/peertube/traefik.toml")}")}
- path: /peertube/traefik/acme.json
  permissions: '0600'
  content: ""
runcmd: []
EOF

  network {
    uuid = "${openstack_networking_network_v2.net_internal.id}"
  }
}

data "template_file" "peertube_environment" {
  template = "${file("${path.module}/files/peertube/peertube-environment.env")}"
  vars = {
    postgres_password = "${random_id.postgres_password.hex}"
  }
}
