# METADA
common.metadata creates a standard metadata header.
It creates a 'metadata:' section with name and labels.

**Usage:**

```yaml
  1. {{ include "common.metadata" . }}
  2. {{ include "common.metadata" .context }}
  3. {{ include "common.metadata" ( dict "name" .name "context" .context ) }}
  4. {{ include "common.metadata" ( dict "generateName" .job.generateName "context" .context ) }}
```

___
Return to [Common components](./README.md)
