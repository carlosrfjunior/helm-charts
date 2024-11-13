{{- /* START

`common.job` sets the default job header

**Usage:**

```yaml
  {{ include "common.job" ( dict "job" . "context" $ )  }}
  spec:
    ...
```

END */ -}}
{{- define "common.job" }}
apiVersion: batch/v1
kind: Job
{{- if .job.generateName }}
{{ include "common.metadata" ( dict "generateName" .job.generateName "context" .context ) }}
{{- else }}
{{ include "common.metadata" ( dict "name" .jobName "context" .context ) }}
{{- end }}
  {{- with .job.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}
