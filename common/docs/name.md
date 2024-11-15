# NAME

name defines a template for the name of the chart. It should be used for the `app` label.
This is common practice in many Kubernetes manifests, and is not Helm-specific.

The prevailing wisdom is that names should only contain a-z, 0-9 plus dot (.) and dash (-), and should
not exceed 63 characters.

Parameters:

- `.Values.nameOverride`: Replaces the computed name with this given name
- `.Values.namePrefix`: Prefix
- `.Values.global.namePrefix`: Global prefix
- `.Values.nameSuffix`: Suffix
- `.Values.global.nameSuffix`: Global suffix

The applied order is: **"global prefix + prefix + name + suffix + global suffix"**

**Usage:**

```yaml
  1. {{- template "common.name" . -}}
  2. {{- template "common.name" .context -}}
```

___
Return to [Common components](./README.md)
