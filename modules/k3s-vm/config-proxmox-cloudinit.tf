resource "proxmox_virtual_environment_download_file" "ubuntu_cloud_image" {
  content_type = "import"
  datastore_id = var.cloud_image_datastore_id
  node_name    = var.node_name
  url          = var.cloud_image_url
  # need to rename the file to *.qcow2 to indicate the actual file format for import
  file_name = "cloudimage.qcow2"
}

# This is so we can get the password in the correct format
resource "null_resource" "hashed_password_generator" {
  provisioner "local-exec" {
    command = "mkpasswd -m sha-512 '${var.vm_pass}' > hashed_password.txt"
  }
}

data "local_file" "hashed_password" {
  depends_on = [null_resource.hashed_password_generator]
  filename   = "hashed_password.txt"
}

resource "proxmox_virtual_environment_file" "k3s_cc" {
  content_type = "snippets"
  datastore_id = var.cloud_image_datastore_id
  node_name    = var.node_name

  source_raw {
    data = <<-EOF
    #cloud-config
    hostname: ${var.vm_name}
    timezone: Europe/Sofia
    users:
      - default
      - name: ${var.ssh_username}
        passwd: ${trimspace(data.local_file.hashed_password.content)} # <--- Use the hashed password here
        lock-passwd: false
        ssh_pwauth: True
        groups:
          - sudo
        shell: /bin/bash
        ssh_authorized_keys:
          - ${trimspace(data.local_file.ssh_public_key.content)}
        sudo: ALL=(ALL) NOPASSWD:ALL
    package_update: true
    packages:
      - qemu-guest-agent
      - net-tools
      - curl
      - python
    runcmd:
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
      - echo "done" > /tmp/cloud-config.done
    EOF

    file_name = "user-data-cloud-config.yaml"
  }
}
