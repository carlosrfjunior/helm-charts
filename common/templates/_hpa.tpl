{{- /* START

Template for Horizontal Pod Autoscaler

**Usage:**

```yaml
{{- include "common.hpa" ( dict "hpa" .Values "context" $ )  }}
```

END */ -}}
{{- define "common.hpa" }}
{{- if .hpa.autoscaling.enabled }}
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: {{ include "common.fullname" .context }}
  labels:
    {{- include "common.labels" .context | nindent 4 }}
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ include "common.fullname" .context }}
  minReplicas: {{ .hpa.autoscaling.minReplicas }}
  maxReplicas: {{ .hpa.autoscaling.maxReplicas }}
  metrics:
    {{- if .hpa.autoscaling.targetCPUUtilizationPercentage }}
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: {{ .hpa.autoscaling.targetCPUUtilizationPercentage }}
    {{- end }}
    {{- if .hpa.autoscaling.targetMemoryUtilizationPercentage }}
    - type: Resource
      resource:
        name: memory
        target:
          type: Utilization
          averageUtilization: {{ .hpa.autoscaling.targetMemoryUtilizationPercentage }}
    {{- end }}
{{- end }}
---
{{- end }}
