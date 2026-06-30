packer {
  required_plugins {
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
  }
}

source "vagrant" "ubuntu_trivy_ssh" {
  add_force    = true
  communicator = "ssh"
  provider     = "virtualbox"
  source_path  = "bento/ubuntu-24.04"
}

build {
  sources = ["source.vagrant.ubuntu_trivy_ssh"]

  provisioner "shell" {
    execute_command = "echo 'packer' | {{.Vars}} sudo -E sh '{{.Path}}'"
    script          = "new_script_for_vagrant.sh"
  }

}
