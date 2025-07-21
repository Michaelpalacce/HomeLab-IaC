# k3s-vm

Helper module to bring up a k3s ready VM.

## Migration

When deciding to redo cluster, remove all instances of:

```hcl
for_each = var.cloud_image_url == "" ? [] : [1]
```

and remove dynamicity. It's not needed anymore
