resource "openstack_compute_keypair_v2" "ssh_deploy_key" {
  name = "Deploy key ${var.deployment_identifier} ${random_id.unique_id.hex}"
  public_key = "${file("~/.ssh/id_rsa.pub")}"
}
