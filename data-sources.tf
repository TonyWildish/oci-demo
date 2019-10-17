data "oci_core_images" "images" {
  compartment_id = "${var.compartment_id}"

  # operating_system = "CentOS"
  # operating_system_version = "7"
  operating_system = "Oracle Linux"
  operating_system_version = "7.7"

  shape = "VM.Standard.E2.1"
  state = "AVAILABLE"
  sort_by = "TIMECREATED"
  sort_order = "DESC"
}
locals {
  image_name = "${data.oci_core_images.images.images[0].display_name}"
  image_id   = "${data.oci_core_images.images.images[0].id}"
}
output "image_name" {
  value = "${local.image_name}"
}
output "image_id" {
  value = "${local.image_id}"
}
