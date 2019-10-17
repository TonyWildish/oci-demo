resource "oci_core_default_security_list" "ssh" {
  manage_default_resource_id = "${oci_core_vcn.vcn.default_security_list_id}"
  display_name = "test-ssh"

  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }

  ingress_security_rules {
    protocol        = "all"
    source          = "10.0.0.0/24"
  }
  ingress_security_rules {
    protocol        = 6
    source          = "0.0.0.0/0"
    tcp_options {
      min = "22"
      max = "22"
    }
  }
}
