provider "oci" {
  tenancy_ocid = "${var.tenancy_ocid}"
  user_ocid = "${var.user_ocid}"
  fingerprint = "6b:f7:29:fb:0b:d6:d3:d1:99:17:f9:0c:1f:0e:92:8a"
  private_key_path = "oci/api.key.pem"
  region = "${var.region}"
}
