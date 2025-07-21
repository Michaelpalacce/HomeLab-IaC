variable "proxmox_endpoint" {
  type        = string
  sensitive   = false
  nullable    = false
  description = "The Proxmox VE endpoint. Can be an IP or URL."
}

variable "proxmox_api_token" {
  type        = string
  sensitive   = true
  nullable    = false
  description = "The API token for the service account in format: terraform@pve!provider=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}

variable "proxmox_ssh_username" {
  type        = string
  sensitive   = false
  nullable    = false
  description = "The SSH username to use to ssh into the proxmox server"
}

variable "proxmox_ssh_password" {
  type        = string
  sensitive   = true
  nullable    = false
  description = "The SSH password to use to ssh into the proxmox server"
}

variable "cloud_image_url" {
  type        = string
  sensitive   = false
  default     = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
  description = "This is the URL for the Ubuntu Cloud Image to download if it's not already downloaded"
  nullable    = false
  ephemeral   = false
}

variable "cloud_image_datastore_id" {
  type        = string
  sensitive   = false
  default     = "nas"
  description = "This is the datastore ID where we will store the cloud image specified in cloud_image_url. The datastore should be enabled for `import` from Datacenter > Storage > then edit the storage to have `Import`."
  nullable    = false
  ephemeral   = false
}

variable "node_name" {
  type        = string
  sensitive   = false
  description = "What is the node_name where the datastore_id is attached and the VM is going to be deployed to?"
  nullable    = false
  ephemeral   = false
}

variable "vm_name" {
  type        = string
  sensitive   = false
  description = "What do you wish your machine to be called?"
  nullable    = false
  ephemeral   = false
}

variable "ssh_public_key_path" {
  type        = string
  sensitive   = false
  default     = "/home/stef/.ssh/id_rsa.pub"
  description = "The full path to the SSH public key. This is needed as we are going to enable key authentication to the new VM."
  nullable    = false
  ephemeral   = false
}

variable "ssh_username" {
  type        = string
  sensitive   = false
  default     = "stefan"
  description = "What do you wish your user to be called?"
  nullable    = false
  ephemeral   = false
}

variable "ssh_passwrod" {
  type        = string
  sensitive   = true
  description = "Sha-512 of the password you want to set."
  nullable    = false
  ephemeral   = false
}

variable "vm_cpu" {
  type = object({
    cores      = number
    sockets    = number
    type       = optional(string)
    units      = optional(number)
    flags      = optional(list(string))
    numa       = optional(bool)
    hotplugged = optional(number)
    limit      = optional(number)
  })
  default = {
    cores      = 3
    sockets    = 2
    type       = "x86-64-v2-AES"
    units      = 1024
    flags      = []
    numa       = false
    hotplugged = 0
    limit      = 0
  }
}

variable "vm_memory" {
  type = object({
    dedicated      = number
    floating       = optional(number)
    keep_hugepages = optional(bool)
    shared         = optional(number)
  })
  default = {
    dedicated      = 8192
    floating       = 0
    keep_hugepages = false
    shared         = 0
  }
  description = "Specify the VM memory. Only `dedicated` is required, which denotes how much memory in MB is to be used."
}

variable "vm_disks" {
  type = list(object({
    datastore_id = string
    interface    = string
    size         = number
    # These are optional attributes that might or might not be present for a given disk
    import_from = optional(string)
    cache       = optional(string)
    discard     = optional(string)
    iothread    = optional(bool)
  }))
  default = [
    # Default is ONLY the Boot Disk configuration
    {
      datastore_id = "local-lvm"
      interface    = "scsi0"
      cache        = "none"
      discard      = "ignore"
      size         = 128
      iothread     = true
    },
  ]
  description = "List of disk configurations for the VM. Defaults to a single boot disk."
}

