# HomeLab-IaC

A public space to store my infrastructure as code components.

## Disclaimer

While this has been a great experiment, Terraform in my opinion is not ideal for creating and managing Virtual Machines, however it's good
for handling some parts of the infrastructure.

Virtual Machines in my infrastructure should be migrated eventually to working with Cluster API. However operations currently are flowing
smoothly and I don't want to recreate my cluster, yet.

## Dependencies

- `.envrc` file with the following structure. You can use `direnv` to load them
```sh
export TF_VAR_proxmox_api_token="terraform@pve!provider=***"
export TF_VAR_proxmox_ssh_password="***"
export TF_VAR_cloudflare_api_key="***"
# your pass mkpasswd -m sha-512 encrypted
export TF_VAR_vm_pass="example"
```
- Nodes with names
    - `prox-1`
    - `prox-2`
    - `prox-3`
    - `prox-5`
- Account created for acme
    - 'stefan'

## Terraform

### Issues

There is a problem with the disks (when working with too many disks, seems like it's 3+, where they may randomly appear out of order. This
is a known bug in the bpg proxmox provider. Don't apply changes if they are detected, seems like it happens 33% of the times.

