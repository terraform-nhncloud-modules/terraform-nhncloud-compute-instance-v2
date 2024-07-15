output "instance_id" {
  description = "The ID of the compute instance."
  value       = nhncloud_compute_instance_v2.compute_instance_v2.id
}

output "instance_name" {
  description = "The name of the compute instance."
  value       = nhncloud_compute_instance_v2.compute_instance_v2.name
}

output "instance_flavor_name" {
  description = "The flavor name of the compute instance."
  value       = nhncloud_compute_instance_v2.compute_instance_v2.flavor_name
}

output "instance_flavor_id" {
  description = "The flavor ID of the compute instance."
  value       = nhncloud_compute_instance_v2.compute_instance_v2.flavor_id
}

output "instance_image_name" {
  description = "The image name used for creating the compute instance."
  value       = nhncloud_compute_instance_v2.compute_instance_v2.image_name
}

output "instance_image_id" {
  description = "The image ID used for creating the compute instance."
  value       = nhncloud_compute_instance_v2.compute_instance_v2.image_id
}

output "instance_key_pair" {
  description = "The key pair name used for accessing the compute instance."
  value       = nhncloud_compute_instance_v2.compute_instance_v2.key_pair
}

output "instance_availability_zone" {
  description = "The availability zone of the compute instance."
  value       = nhncloud_compute_instance_v2.compute_instance_v2.availability_zone
}

output "instance_network_name" {
  description = "The name of the VPC network attached to the compute instance."
  value       = nhncloud_compute_instance_v2.compute_instance_v2.network.0.name
}

output "instance_network_uuid" {
  description = "The ID of the VPC attached to the compute instance."
  value       = nhncloud_compute_instance_v2.compute_instance_v2.network.0.uuid
}

output "instance_network_port" {
  description = "The ID of a port attached to the VPC."
  value       = nhncloud_compute_instance_v2.compute_instance_v2.network.0.port
}

output "instance_security_groups" {
  description = "The security group names associated with the compute instance."
  value       = nhncloud_compute_instance_v2.compute_instance_v2.security_groups
}

output "instance_access_ip_v4" {
  description = "The first detected Fixed IPv4 address."
  value       = nhncloud_compute_instance_v2.compute_instance_v2.access_ip_v4
}

output "instance_access_ip_v6" {
  description = "The first detected Fixed IPv6 address."
  value       = nhncloud_compute_instance_v2.compute_instance_v2.access_ip_v6
}

output "instance_created" {
  description = "The time when the instance was created."
  value       = nhncloud_compute_instance_v2.compute_instance_v2.created
}

output "instance_updated" {
  description = "The time when the instance was last updated."
  value       = nhncloud_compute_instance_v2.compute_instance_v2.updated
}
