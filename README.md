<p align="center">
<a href="https://github.com/carlosrfjunior/helm-charts">
<image src="https://avatars.githubusercontent.com/u/180111812?s=400&u=cda6d53ade890c5d47426504081e4fcb1167199d&v=4" style="width: 300px;">
</a>
</p>

# Helm Charts Repository

## Requeriments

- [Helm v3](https://helm.sh)
- [Helm S3 Plugin](https://helm-s3.hypnoglow.io/)
- [Pre-commit](https://pre-commit.com/)

## How to use

```console
helm repo add carlosrfjunior https://carlosrfjunior.github.io/helm-charts/
helm install microservice carlosrfjunior/microservice -f values.yaml
```

## Docs

### Resources

#### Common

- The [common](./common/README.md) project aims to make pre-developed components available to be shared between charts using code reuse, avoiding duplicate code and ensuring global standardization of the use of internal components.

### Usage example

**Other examples in [microservice](./microservice/values.yaml)**

<details>
<summary><b>Adding an Ingress</b></summary>

1. Template File for Ingress

```yaml
{{ range .Values.ingress }}
{{ if .enabled }}
{{- include "common.ingress" ( dict "ingress" . "context" $ )  }}
{{- end }}
{{- end }}
```

2. Template File for Secret Provider Class

```yaml
{{ range .Values.secretProvider }}
{{ if .enabled }}
{{- include "common.secretProvider" ( dict "secretProvider" . "context" $ )  }}
{{- end }}
{{- end }}
```

3. Values File

```yaml
secretProvider:
- enabled: true
    name: "google-account"
    provider: aws
    region: us-east-1
    objects:
    - name: "/owner/env/resource/oidc"
        type: "secretsmanager"
        secretObjects: true # Store secrets in a Kubernetes Secrets instead of adding them to a POD.
        paths:
        - name: "clientID"
            alias: "clientID"
        - name: "clientSecret"
            alias: "clientSecret"

ingress:
- enabled: true
    name: my-ingress-x
    auth:
        type: oidc
        provider: aws
        issuer: "https://accounts.google.com"
        endpoints:
            authorization: "https://accounts.google.com/o/oauth2/v2/auth"
            token: "https://oauth2.googleapis.com/token"
            userInfo: "https://openidconnect.googleapis.com/v1/userinfo"
        secretName:  "google-account"
    annotations:
        alb.ingress.kubernetes.io/group.name: alb-auth
        alb.ingress.kubernetes.io/listen-ports: '[{"HTTPS":443}]'
        alb.ingress.kubernetes.io/scheme: internet-facing
        alb.ingress.kubernetes.io/tags: >-
            company:product=xxx,company:environment=dev,company:owner=xxxx,company:cost-center=x,company:resource=alb,company:xxxx-classification=false
        alb.ingress.kubernetes.io/target-type: ip
    className: alb
    hosts:
    - host: xxxx.company.com
        paths:
        - path: /*
            pathType: ImplementationSpecific
            servicePort: 80
```

</details>
