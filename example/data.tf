data "nhncloud_compute_flavor_v2" "u2c2m4" {
  name = "u2.c2m4"
}
data "nhncloud_images_image_v2" "ubuntu_2004_20201222" {
  name        = "Ubuntu Server 20.04.1 LTS (2020.12.22)"
  most_recent = true
}