# METADATALABELS

`common.labelize` takes a dict or map and generates labels.

Values will be quoted. Keys will not.

**Example output:**

  - first: "Matt"
  - last: "Butcher"

**Usage:**

```yaml
{{- include "common.labelize" ( dict "first" "Matt" "last" "Butcher" ) }}
```

`common.labels` generates common labels for a Kubernetes resource.

**Usage:**

```yaml
{{ include "common.labels" .context | indent 4 -}}
````

___
Return to [Common components](./README.md)
