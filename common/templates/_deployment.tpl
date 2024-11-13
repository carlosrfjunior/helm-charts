{{- /* START

Template for deployment.

**Usage:**

```yaml
{{- include "common.deploy" ( dict "deploy" .Values "context" $ )  }}
```

END */ -}}
{{- define "common.deploy" }}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "common.fullname" .context }}
  labels:
    {{- include "common.labels" .context | nindent 4 }}
spec:
  {{- if not .deploy.autoscaling.enabled | default false }}
  replicas: {{ .deploy.replicaCount }}
  {{- end }}
  selector:
    matchLabels:
      {{- include "common.selectorLabels" .context | nindent 6 }}
  template:
    metadata:
      {{- with .deploy.podAnnotations }}
      annotations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      labels:
        {{- include "common.labels" .context | nindent 8 }}
        {{- with .deploy.podLabels }}
        {{- toYaml . | nindent 8 }}
        {{- end }}
    spec:
      {{- with .deploy.imagePullSecrets }}
      imagePullSecrets:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      serviceAccountName: {{ include "common.serviceAccountName" .context }}
      securityContext:
        {{- toYaml .deploy.podSecurityContext | nindent 8 }}
      containers:
        - name: {{ include "common.fullname" .context | default .context.Chart.Name }}
          securityContext:
            {{- toYaml .deploy.securityContext | nindent 12 }}
          image: "{{ .deploy.image.repository }}:{{ .deploy.image.tag | default .context.Chart.AppVersion }}"
          imagePullPolicy: {{ .deploy.image.pullPolicy }}
          ports:
            - name: http
              containerPort: {{ .deploy.service.port }}
              protocol: TCP
          livenessProbe:
            {{- toYaml .deploy.livenessProbe | nindent 12 }}
          readinessProbe:
            {{- toYaml .deploy.readinessProbe | nindent 12 }}
          resources:
            {{- toYaml .deploy.resources | nindent 12 }}
          {{- with .deploy.volumeMounts }}
          volumeMounts:
            {{- toYaml . | nindent 12 }}
          {{- end }}
      {{- with .deploy.volumes }}
      volumes:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .deploy.nodeSelector }}
      nodeSelector:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .deploy.affinity }}
      affinity:
        {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .deploy.tolerations }}
      tolerations:
        {{- toYaml . | nindent 8 }}
      {{- end }}
---
{{- end }}
