# INGRESSAUTH

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

___
Return to [Common components](./README.md)
