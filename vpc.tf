resource "oci_core_vcn" "vcn" {
  cidr_block = "10.0.0.0/24"
  compartment_id = "${var.compartment_id}"

  display_name = "test-vcn"
  dns_label = "vcn"
}

resource "oci_core_internet_gateway" "gateway" {
  compartment_id = "${var.compartment_id}"
  display_name   = "test-gateway"
  vcn_id         = "${oci_core_vcn.vcn.id}"
}

resource "oci_core_default_route_table" "route" {
  manage_default_resource_id = "${oci_core_vcn.vcn.default_route_table_id}"
  display_name   = "test-route"

  route_rules {
    destination       = "0.0.0.0/0"
    destination_type  = "CIDR_BLOCK"
    network_entity_id = "${oci_core_internet_gateway.gateway.id}"
  }
}

resource "oci_core_subnet" "subnet" {
  cidr_block = "10.0.0.0/24"
  compartment_id = "${var.compartment_id}"
  vcn_id = "${oci_core_vcn.vcn.id}"

  availability_domain = "${var.availability_domain}"
  display_name = "test-subnet"

  dns_label = "subnet"
  route_table_id = "${oci_core_vcn.vcn.default_route_table_id}"
  security_list_ids = [ oci_core_default_security_list.ssh.id ]
  dhcp_options_id     = "${oci_core_vcn.vcn.default_dhcp_options_id}"
}
