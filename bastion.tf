resource "oci_core_instance" "bastion" {
  availability_domain = "${var.availability_domain}"
  compartment_id = "${var.compartment_id}"
  shape = "VM.Standard.E2.1"

  subnet_id = "${oci_core_subnet.subnet.id}"
  create_vnic_details {
    subnet_id = "${oci_core_subnet.subnet.id}"
  }

  display_name = "test-bastion"

  source_details {
    source_id = "${local.image_id}"
    source_type = "image"
  }

  metadata = {
    ssh_authorized_keys = "${tls_private_key.key.public_key_openssh}"
  }

  connection {
    user        = "opc"
    private_key = "${tls_private_key.key.private_key_pem}"
    agent       = false
    host        = "${oci_core_instance.bastion.public_ip}"
  }
}

output "bastion_ip" {
  value = "${oci_core_instance.bastion.public_ip}"
}