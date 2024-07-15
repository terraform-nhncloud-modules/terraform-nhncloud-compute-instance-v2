terraform {
  required_providers {
    nhncloud = {
      source = "nhn-cloud/nhncloud"
    }
  }
  required_version = ">= 1.0.2"
}

provider "nhncloud" {
  region = "KR1"
}

resource "nhncloud_networking_vpc_v2" "sample_vpc" {
  name   = "tf-vpc-01"
  cidrv4 = "10.0.0.0/8"
}

resource "nhncloud_networking_port_v2" "sample_port" {
  name           = "tf_port_1"
  network_id     = nhncloud_networking_vpc_v2.sample_vpc.id
  admin_state_up = "true"
}

module "compute_instance_v2" {
  source          = "../"
  name            = "sample-instance"
  region          = "KR2"
  key_pair        = "terraform-keypair"
  flavor_id       = data.nhncloud_compute_flavor_v2.u2c2m4.id
  security_groups = ["default", "web"]
  network = [
    {
      port = nhncloud_networking_port_v2.sample_port.id
    },
    {
      name = nhncloud_networking_vpc_v2.sample_vpc.name
      uuid = nhncloud_networking_vpc_v2.sample_vpc.id
    }
  ]
  block_device = [
    {
      uuid                  = data.nhncloud_images_image_v2.ubuntu_2004_20201222.id
      source_type           = "image"
      destination_type      = "volume"
      boot_index            = 0
      volume_size           = 20
      delete_on_termination = true
    },
    {
      source_type           = "blank"
      destination_type      = "volume"
      boot_index            = 1
      volume_size           = 20
      delete_on_termination = true
    }
  ]
}