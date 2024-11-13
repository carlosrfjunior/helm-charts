# FULLNAME

fullname defines a suitably unique name for a resource by combining
the release name and the chart name.

The prevailing wisdom is that names should only contain a-z, 0-9 plus dot (.) and dash (-), and should
not exceed 63 characters.

**Parameters:**

- `.Values.fullnameOverride: Replaces the computed name with this given name`
- `.Values.fullnamePrefix: Prefix`
- `.Values.global.fullnamePrefix: Global prefix`
- `.Values.fullnameSuffix: Suffix`
- `.Values.global.fullnameSuffix: Global suffix`

The applied order is: "global prefix + prefix + name + suffix + global suffix"

**Usage:**

```yaml
1. {{- include "common.fullname" . -}}
2. {{- include "common.fullname" .context -}}
3. {{- template "common.fullname" . -}}
4. {{- template "common.fullname" .context -}}
```

___
Return to [Common components](./README.md)
