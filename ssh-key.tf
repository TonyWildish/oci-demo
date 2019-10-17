resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits = 2048
}

resource "local_file" "key_file" {
  filename = "state/ssh-key"
  content  = tls_private_key.key.private_key_pem

  provisioner "local-exec" {
    command = "chmod 600 state/ssh-key"
  }
}

resource "local_file" "key_pub_openssh" {
  filename = "state/ssh-key.pub"
  content  = tls_private_key.key.public_key_openssh

  provisioner "local-exec" {
    command = "chmod 600 state/ssh-key"
  }
}

resource "local_file" "key_pub_pem" {
  filename = "state/ssh-key.pub.pem"
  content  = tls_private_key.key.public_key_pem

  provisioner "local-exec" {
    command = "chmod 600 state/ssh-key"
  }
}