{{/* START

Create the name of the service account to use

**Usage:**
```yaml
{{- include "common.serviceAccountName" . }}
```
END */}}
{{- define "common.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "common.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
