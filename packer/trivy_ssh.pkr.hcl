packer {
  required_plugins {
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "1.1.7"
    }
    ansible = {
      version = "1.1.5"
      source  = "github.com/hashicorp/ansible"
    }
  }
}
source "vagrant" "ubuntu_trivy_ssh" {
  add_force    = true
  communicator = "ssh"
  provider     = "virtualbox"
  source_path  = "bento/ubuntu-26.04"
}

build {
  sources = ["source.vagrant.ubuntu_trivy_ssh"]
  provisioner "ansible" {
    playbook_file = "./packer_playbook.yaml"
    galaxy_file   = "./requirements.yaml"
  }
}
