{{- /* START

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

END */ -}}
{{- define "common.labelize" -}}
{{- range $k, $v := . }}
{{ $k }}: {{ $v | quote }}
{{- end -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "common.labels" -}}
helm.sh/chart: {{ include "common.chart" . }}
{{ include "common.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "common.selectorLabels" -}}
app.kubernetes.io/name: {{ include "common.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
