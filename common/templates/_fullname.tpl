{{- /* START

fullname defines a suitably unique name for a resource by combining
the release name and the chart name.

The prevailing wisdom is that names should only contain a-z, 0-9 plus dot (.) and dash (-), and should
not exceed 63 characters.

**Parameters:**

- `.Values.fullnameOverride: Replaces the computed name with this given name`
- `.Values.fullnamePrefix: Prefix`
- `.Values.global.fullnamePrefix: Global prefix`
- `.Values.fullnameSuffix: Suffix`
- `.Values.global.fullnameSuffix: Global suffix`

The applied order is: "global prefix + prefix + name + suffix + global suffix"

**Usage:**

```yaml
1. {{- include "common.fullname" . -}}
2. {{- include "common.fullname" .context -}}
3. {{- template "common.fullname" . -}}
4. {{- template "common.fullname" .context -}}
```

END */ -}}
{{- define "common.fullname"}}
  {{- $global := default (dict) .Values.global -}}
  {{- $name := default .Chart.Name .Values.nameOverride }}
  {{- if contains $name .Release.Name }}
  {{- $name := default .Release.Name }}
  {{- else }}
  {{- $name := default (printf "%s-%s" .Release.Name) }}
  {{- end }}
  {{- $base := default $name .Values.fullnameOverride -}}
  {{- $gpre := default "" $global.fullnamePrefix -}}
  {{- $pre := default "" .Values.fullnamePrefix -}}
  {{- $suf := default "" .Values.fullnameSuffix -}}
  {{- $gsuf := default "" $global.fullnameSuffix -}}
  {{- $name := print $gpre $pre $base $suf $gsuf -}}
  {{- $name | lower | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- /*
common.fullname.unique adds a random suffix to the unique name.

This takes the same parameters as common.fullname

*/ -}}
{{- define "common.fullname.unique" -}}
  {{ template "common.fullname" . }}-{{ randAlphaNum 7 | lower }}
{{- end }}
