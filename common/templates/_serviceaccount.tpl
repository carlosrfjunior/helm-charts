{{- /* START

Template for Service Account

**Usage:**

```yaml
{{- include "common.sa" ( dict "sa" .Values "context" $ )  }}
```

END */ -}}
{{- define "common.sa" }}
{{- if .sa.serviceAccount.create -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  name: {{ include "common.serviceAccountName" .context }}
  labels:
    {{- include "common.labels" .context | nindent 4 }}
  {{- with .sa.serviceAccount.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
automountServiceAccountToken: {{ .sa.serviceAccount.automount }}
{{- end }}
---
{{- end }}
