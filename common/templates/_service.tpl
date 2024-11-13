{{- /* START

Template for Netowork Service.

**Usage:**

```yaml
{{- include "common.service" ( dict "service" .Values "context" $ )  }}
```

END */ -}}
{{- define "common.service" }}
apiVersion: v1
kind: Service
metadata:
  name: {{ include "common.fullname" .context }}
  labels:
    {{- include "common.labels" .context | nindent 4 }}
spec:
  type: {{ .service.service.type }}
  ports:
    - port: {{ .service.service.port }}
      targetPort: http
      protocol: TCP
      name: http
  selector:
    {{- include "common.selectorLabels" .context | nindent 4 }}
---
{{- end }}
