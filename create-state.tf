resource "null_resource" "create_state" {
  provisioner "local-exec" {
    command = "rm -rf ./state && mkdir -p ./state"
  }
}
