{{- /* START

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

END */ -}}
{{- define "common.ingress" }}
{{- $fullName := required "A valid name is required!" .ingress.name -}}
{{- if and .ingress.className (not (semverCompare ">=1.18-0" $.context.Capabilities.KubeVersion.GitVersion)) }}
  {{- if not (hasKey .ingress.annotations "kubernetes.io/ingress.class") }}
  {{- $_ := set .ingress.annotations "kubernetes.io/ingress.class" .ingress.className}}
  {{- end }}
{{- end }}
{{- if semverCompare ">=1.19-0" $.context.Capabilities.KubeVersion.GitVersion -}}
apiVersion: networking.k8s.io/v1
{{- else if semverCompare ">=1.14-0" $.context.Capabilities.KubeVersion.GitVersion -}}
apiVersion: networking.k8s.io/v1beta1
{{- else -}}
apiVersion: extensions/v1beta1
{{- end }}
kind: Ingress
metadata:
  name: {{ $fullName }}
  labels:
    {{- include "common.labels" $.context | nindent 4 }}
  {{- with .ingress.annotations }}
  annotations:
    {{- if $.ingress.auth }}
    {{- include "common.ingress.auth" ( dict "ingressAuth" $.ingress.auth "context" $.context ) | nindent 4 }}
    {{- end }}
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- if and .ingress.className (semverCompare ">=1.18-0" $.context.Capabilities.KubeVersion.GitVersion) }}
  ingressClassName: {{ .ingress.className }}
  {{- end }}
  {{- if .ingress.tls }}
  tls:
    {{- range .ingress.tls }}
    - hosts:
        {{- range .hosts }}
        - {{ . | quote }}
        {{- end }}
      secretName: {{ .secretName }}
    {{- end }}
  {{- end }}
  rules:
    {{- range .ingress.hosts }}
    - host: {{ .host | quote }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
            {{- if and .pathType (semverCompare ">=1.18-0" $.context.Capabilities.KubeVersion.GitVersion) }}
            pathType: {{ .pathType }}
            {{- end }}
            backend:
              {{- if semverCompare ">=1.19-0" $.context.Capabilities.KubeVersion.GitVersion }}
              service:
                name: {{ .serviceName | default $fullName }}
                port:
                  number: {{ required "A valid service port is required!" .servicePort }}
              {{- else }}
              serviceName: {{ .serviceName | default $fullName }}
              servicePort: {{ required "A valid service port is required!" .servicePort }}
              {{- end }}
          {{- end }}
    {{- end }}
---
{{- end }}
