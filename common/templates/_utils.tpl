{{- /* START

### common.utils.merge

it will merge two YAML templates and output the result.

This takes an array of three values:
- the top context
- the template name of the overrides (destination)
- the template name of the base (source)


**Usage:**
```yaml
{{- template "common.utils.merge" (list . "common.ingress.override.tpl" "common.ingress.tpl") -}}`
{{- template "common.utils.merge" (append . "common.ingress.tpl") -}}
```

END */ -}}
{{- define "common.utils.merge" -}}
{{- $top := first . -}}
{{- $overrides := fromYaml (include (index . 1) $top) | default (dict ) -}}
{{- $tpl := fromYaml (include (index . 2) $top) | default (dict ) -}}
{{- toYaml (merge $overrides $tpl) -}}
{{- end -}}
