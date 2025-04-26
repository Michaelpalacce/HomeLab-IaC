# HomeLab-IaC

A public space to store my infrastructure as code components.

## Dependencies


- `.envrc` file with the following structure. You can use `direnv` to load them
```sh
export TF_VAR_proxmox_api_token="terraform@pve!provider=***"
export TF_VAR_proxmox_ssh_password="***"
export TF_VAR_cloudflare_api_key="***"
```
- Nodes with names
    - `prox-1`
    - `prox-2`
    - `prox-3`
    - `prox-5`
- Account created for acme
    - 'stefan'

## Terraform

## ...
