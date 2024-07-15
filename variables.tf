variable "region" {
  description = "(Optional) The region of the block storage to create. The default is the region configured in the provider."
  type        = string
  default     = null
  validation {
    condition     = can(regex("^(KR1|KR2|JP1)$", var.region))
    error_message = "The region must be one of 'KR1', 'KR2', 'JP1'."
  }
}

variable "name" {
  description = "(Required) The name of the instance to create."
  type        = string
  validation {
    condition     = length(var.name) > 0
    error_message = "The name of the instance must not be empty."
  }
}

variable "flavor_name" {
  description = "(Optional) The flavor name of the instance to create. Required if flavor_id is empty."
  type        = string
  default     = null
}

variable "flavor_id" {
  description = "(Optional) The flavor ID of the instance to create. Required if flavor_name is empty."
  type        = string
  default     = null
}

variable "image_name" {
  description = "(Optional) The image name to use for creating an instance. Required if image_id is empty. Available only when the flavor is U2."
  type        = string
  default     = null
}

variable "image_id" {
  description = "(Optional) The image ID to use for creating an instance. Required if image_name is empty. Available only when the flavor is U2."
  type        = string
  default     = null
}

variable "key_pair" {
  description = "(Optional) The key pair name to use for accessing the instance."
  type        = string
  default     = null
}

variable "availability_zone" {
  description = "(Optional) The availability zone of an instance to create."
  type        = string
  default     = null
}

variable "network" {
  description = <<EOF
(Optional) The network configuration for the instance. The network block supports the following arguments:
- name: (Optional) The name of the VPC network. One among network.name, network.uuid, and network.port must be specified.
- uuid: (Optional) The ID of the VPC. One among network.name, network.uuid, and network.port must be specified.
- port: (Optional) The ID of a port to be attached to VPC. One among network.name, network.uuid, and network.port must be specified.
EOF
  type = list(object({
    name = optional(string)
    uuid = optional(string)
    port = optional(string)
  }))
  default = null
  validation {
    condition     = alltrue([for network in var.network : length(compact([network.name, network.uuid, network.port])) == 1])
    error_message = "One among network.name, network.uuid, and network.port must be specified."
  }
}

variable "security_groups" {
  description = "(Optional) List of the security group names for instance."
  type        = list(string)
  default     = []
}

variable "user_data" {
  description = "(Optional) The script to be executed after instance booting and its configuration. Base64-encoded string, which allows up to 65535 bytes."
  type        = string
  default     = null
}

variable "block_device" {
  description = <<EOF
(Optional) The block storage configuration for the instance. The block_device block supports the following arguments:
- uuid: (Optional) The ID of the original block storage. Volumes or snapshots which cannot be used to create images, such as those with WAF, MS-SQL images as the source, cannot be used.
- source_type: (Optional) The type of the original block storage to create. Options are 'image', 'volume', 'snapshot'.
- destination_type: (Optional) Requires different settings depending on the location of instance’s block storage or flavor. Options are 'local' for U2 flavor, 'volume' for flavors other than U2.
- boot_index: (Optional) The order to boot the specified block storage. The higher the number, the lower the booting priority.
- volume_size: (Optional) The block storage size for the instance to create. Available from 20 GB to 2,000 GB (required if the flavor is U2).
- delete_on_termination: (Optional) true: When deleting an instance, delete a block device. false: When deleting an instance, do not delete a block.
EOF
  type = list(object({
    uuid                  = optional(string)
    source_type           = string
    destination_type      = string
    boot_index            = number
    volume_size           = number
    delete_on_termination = bool
    nhn_encryption = optional(object({
      skm_appkey = string
      skm_key_id = string
    }))
  }))
  default = []
  validation {
    condition     = alltrue([for block_device in var.block_device : block_device.source_type == "" || contains(["blank", "image", "volume", "snapshot"], block_device.source_type)])
    error_message = "The source type must be one of 'blank', 'image', 'volume', 'snapshot'."
  }
  validation {
    condition     = alltrue([for block_device in var.block_device : block_device.destination_type == "" || contains(["local", "volume"], block_device.destination_type)])
    error_message = "The destination type must be one of 'local', 'volume'."
  }
  validation {
    condition     = alltrue([for block_device in var.block_device : block_device.volume_size == 0 || (block_device.volume_size >= 20 && block_device.volume_size <= 2000)])
    error_message = "The block storage size must be between 20 GB and 2,000 GB."
  }
}