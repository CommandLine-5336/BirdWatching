# Packer image

## Requirements
* Packer 1.15.4
* Vagrant 2.4.9
* VirtualBox

## Installing / Getting started

* Packer should be installed https://developer.hashicorp.com/packer/install
* After installing packer, `cd` into the folder with the pkr.hcl file
* Inside the folder do `packer init` in bash
* `packer fmt ./{FILE_NAME.pkr.hcl}` and `packer validate ./{FILE_NAME.pkr.hcl}`
* `packer build ./{FILE_NAME.pkr.hcl}` inside of bash in order to start building the VM inside of VirtualBox

## Features

* Creates a .box with 4 public keys and regular Trivy Security scans
