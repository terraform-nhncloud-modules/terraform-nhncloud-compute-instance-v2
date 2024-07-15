resource "nhncloud_compute_instance_v2" "compute_instance_v2" {
  name            = var.name
  region          = var.region
  flavor_name     = var.flavor_name
  flavor_id       = var.flavor_id
  image_name      = var.image_name
  image_id        = var.image_id
  key_pair        = var.key_pair
  security_groups = var.security_groups

  dynamic "network" {
    for_each = toset(var.network)
    content {
      name = network.value.name
      uuid = network.value.uuid
      port = network.value.port
    }
  }

  dynamic "block_device" {
    for_each = toset(var.block_device)
    content {
      uuid                  = block_device.value.uuid
      source_type           = block_device.value.source_type
      destination_type      = block_device.value.destination_type
      boot_index            = block_device.value.boot_index
      volume_size           = block_device.value.volume_size
      delete_on_termination = block_device.value.delete_on_termination
    }
  }
}