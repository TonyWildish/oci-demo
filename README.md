# oci-demo
demonstration of a problem with OCI CentOS images

# TL;DR
OCI provides some CentOS images. If you boot one, then run a 'yum update', then reboot it, it doesn't come back.

# The longer version...
This code demonstrates the problem. To reproduce it:
- clone this repository
- create a directory **oci**, put your API key in **oci/api.key.pem**
- edit **provider.tf** and set the API fingerprint there
- copy **account.tfvars.template** to **account.tfvars**
- edit **account.tfvars**  and set the variables there
- (optional) edit **vars.tf** and change the **availability_domain** and **region**
- run **terraform apply --var-file account.tfvars**
  - N.B. You'll need terraform 0.12 or up for this

The code in **data-sources.tf** picks out the latest version of the CentOS-7 image and sets two local variables. In **bastion.tf**, these are used to boot an image. The rest is just fluff to make it all happen.

Once the image is booted you'll get some output on the screen, something like this:
```
bastion_ip = xxx.xxx.xxx.xxx
image_id = ocid1.image.oc1.uk-london-1....
image_name = CentOS-7-2019.08.20-0
```

This shows you the image that was used for booting the host, and the public IP number. You can then SSH into the image:
```
ssh -o 'UserKnownHostsFile /dev/null' -o 'StrictHostKeyChecking no' -i state/ssh-key opc@<IP-NUMBER>
```

So far, so good. Now try updating the software and rebooting the image:
```
sudo yum update -y
sudo reboot
```
Note that the yum update will take a loooong time, 15-20 minutes. 'dracut' gets run for the updated kernel, and that takes forever.

Wait as long as you like for the machine to reboot, then try to SSH into it again. It never responds.

To prove this is a problem with the CentOS image, not the terraform code, first destroy this setup, then go into **data-sources.tf** and edit the **operating_system** and **operating_system_version** variables. I show examples for switching to Oracle Linux version 7.7. Repeat the procedure, and when you reboot the host it will come back just fine.