{{- /* START

Common Ingress Auth defines pre-structured OIDC settings for template usage.

**Usage:**

```yaml
  1. {{ include "common.ingress.auth" ( dict "ingressAuth" . "context" . ) | nindent 4 }}
  2. {{ include "common.ingress.auth" ( dict "ingressAuth" $.ingress.auth "context" $.context ) | nindent 4 }}
  3. {{- template "common.ingress.auth" . -}}
  4. {{- template "common.ingress.auth" .context -}}
```

**Example:**

```yaml
apiVersion: networking.k8s.io/v1
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
````

**References:**
- https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/annotations/
- https://kubernetes-sigs.github.io/aws-load-balancer-controller/v2.9/guide/ingress/annotations/

END */ -}}
{{- define "common.ingress.auth" -}}
{{- if and (eq .ingressAuth.type "oidc") (eq .ingressAuth.provider "aws") -}}
alb.ingress.kubernetes.io/auth-idp-oidc: >
  {
    "issuer": {{ .ingressAuth.issuer | quote  }},
    "authorizationEndpoint": {{ .ingressAuth.endpoints.authorization | quote }},
    "tokenEndpoint": {{ .ingressAuth.endpoints.token | quote  }},
    "userInfoEndpoint": {{ .ingressAuth.endpoints.userInfo | quote }},
    "secretName": {{ .ingressAuth.secretName | quote }}
  }
alb.ingress.kubernetes.io/auth-on-unauthenticated-request: {{ .ingressAuth.onUnauthenticatedRequest | default  "authenticate" | quote }}
alb.ingress.kubernetes.io/auth-scope: {{ .ingressAuth.scope | default "openid profile email" | quote  }}
alb.ingress.kubernetes.io/auth-session-cookie: {{ .ingressAuth.sessionCookie | default "AWSELBAuthSessionCookie" | quote  }}
alb.ingress.kubernetes.io/auth-session-timeout: {{ .ingressAuth.sessionTimeout | default "86400" | quote }}
alb.ingress.kubernetes.io/auth-type: oidc
{{- end -}}
{{- if and (eq .ingressAuth.type "basic") (eq .ingressAuth.provider "nginx") -}}
nginx.ingress.kubernetes.io/auth-type: basic
nginx.ingress.kubernetes.io/auth-secret: {{ .ingressAuth.secretName | quote }}
nginx.ingress.kubernetes.io/auth-realm: {{ .ingressAuth.realm | quote }}
{{- end -}}
{{- end -}}
