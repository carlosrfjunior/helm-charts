# INGRESS

The Common Ingress template provides the standardized and structured component with all predefined parameters for simplified use.

**Usage:**

```yaml
{{- include "common.ingress" ( dict "ingress" $.ingress "context" $ )  }}
```

**Example:**

```yaml
{{ range .Values.ingress }}
{{ if .enabled }}
{{- include "common.ingress" ( dict "ingress" . "context" $ )  }}
{{- end }}
{{- end }}
```

___
Return to [Common components](./README.md)
