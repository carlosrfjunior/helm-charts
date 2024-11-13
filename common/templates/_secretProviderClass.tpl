{{- /* START

`common.secretProvider` template to create a SecretProviderClass object.

**Usage:**

```yaml
  1. {{- include "common.secretProvider" ( dict "secretProvider" $.Values.secretProvider "context" $ )  }}
```

END */ -}}
{{- define "common.secretProvider" }}
apiVersion: secrets-store.csi.x-k8s.io/v1
kind: SecretProviderClass
{{ include "common.metadata" ( dict "name" .secretProvider.name "context" .context ) }}
spec:
    {{- if .secretProvider.provider }}
    provider: "{{ .secretProvider.provider }}"
    {{- end }}
    {{- if .secretProvider.region }}
    region: "{{ .secretProvider.region }}"
    {{- end }}
    {{- if .secretProvider.failoverRegion }}
    failoverRegion: {{ .secretProvider.failoverRegion }}
    {{- end }}
    {{- if .secretProvider.pathTranslation }}
    pathTranslation: {{ .secretProvider.pathTranslation }}
    {{- end }}
    parameters:
        objects: |
            {{- range $obj := .secretProvider.objects }}
            - objectName: "{{ $obj.name }}"
              {{- if $obj.type }}
              objectType: "{{ $obj.type }}"
              {{- end }}
              {{- if $obj.alias }}
              objectAlias: "{{ $obj.alias }}"
              {{- end }}
              {{- if $obj.version }}
              objectVersion: "{{ $obj.version }}"
              {{- end }}
              {{- if $obj.versionLabel }}
              objectVersionLabel: "{{ $obj.versionLabel }}"
              {{- end }}
              {{- if $obj.paths }}
              jmesPath:
              {{- range $path := $obj.paths }}
                - path: "{{ $path.name }}"
                  {{- if $path.alias }}
                  objectAlias: "{{ $path.alias }}"
                  {{- end }}
              {{- end }}
              {{- end }}
              {{- if $obj.failover }}
              failoverObject:
              {{- range $fail := $obj.failover }}
                - objectName: "{{ $fail.name }}"
                {{- if $fail.version }}
                  objectVersion: '{{ $fail.version }}'
                {{- end }}
                {{- if $fail.versionLabel }}
                  objectVersionLabel: "{{ $fail.versionLabel }}"
                {{- end -}}
              {{- end -}}
              {{- end -}}
            {{- end -}}
  {{- range $obj := .secretProvider.objects }}
    {{- if .secretObjects }}
    secretObjects:
      - secretName: {{ required "The Secret Provider name is required!" $.secretProvider.name }}
        type: Opaque
        data:
          {{- if $obj.paths }}
          {{- range $path := $obj.paths }}
          {{- if $path.alias }}
          - objectName: "{{ $path.alias }}"
          {{- else }}
          - objectName: "{{ $path.name }}"
          {{- end }}
            {{- if $path.key }}
            key: "{{ $path.key }}"
            {{ else}}
            {{- if $path.alias }}
            key: "{{ $path.alias }}"
            {{- else}}
            key: "{{ $path.name }}"
            {{- end }}
            {{- end }}
          {{- end }}
          {{ else }}
          {{- if $obj.alias }}
          - objectName: "{{ $obj.alias }}"
          {{ else}}
          - objectName: "{{ $obj.name }}"
          {{- end }}
            {{- if $obj.key }}
            key: "{{ $obj.key }}"
            {{ else}}
            {{- if $obj.alias }}
            key: "{{ $obj.alias }}"
            {{ else}}
            key: "{{ $obj.name }}"
            {{- end }}
            {{- end }}
          {{- end }}
    {{- end }}
  {{- end }}
---
{{- end }}
{{- /*
1. https://docs.aws.amazon.com/systems-manager/latest/userguide/integrating_csi_driver.html
2. https://docs.aws.amazon.com/secretsmanager/latest/userguide/integrating_csi_driver_SecretProviderClass.html
3. https://aws.amazon.com/blogs/security/how-to-use-aws-secrets-configuration-provider-with-kubernetes-secrets-store-csi-driver/
4. https://secrets-store-csi-driver.sigs.k8s.io/topics/sync-as-kubernetes-secret
*/ -}}
