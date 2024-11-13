{{/* START

Create chart name and version as used by the chart label.

**Usage:**

```yaml
{{- include "common.chart" . -}}
```

END */}}
{{- define "common.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
