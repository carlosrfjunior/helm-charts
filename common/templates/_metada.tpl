{{- /* START
common.metadata creates a standard metadata header.
It creates a 'metadata:' section with name and labels.

**Usage:**

```yaml
  1. {{ include "common.metadata" . }}
  2. {{ include "common.metadata" .context }}
  3. {{ include "common.metadata" ( dict "name" .name "context" .context ) }}
  4. {{ include "common.metadata" ( dict "generateName" .job.generateName "context" .context ) }}
```

END */ -}}
{{ define "common.metadata" -}}
metadata:
{{- if .context }}
  {{- if .generateName }}
  generateName: {{ trimSuffix "-" .generateName }}-
  {{- else if .name }}
  name: {{ required "The metadata name is required!" .name }}
  {{- else }}
  name: {{ template "common.fullname" .context }}
  {{- end }}
  labels:
{{ include "common.labels" .context | indent 4 -}}
{{ else }}
  name: {{ template "common.fullname" . }}
  labels:
{{ include "common.labels" . | indent 4 -}}
{{- end -}}
{{- end -}}
