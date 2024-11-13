# SECRETPROVIDERCLASS

`common.secretProvider` template to create a SecretProviderClass object.

**Usage:**

```yaml
  1. {{- include "common.secretProvider" ( dict "secretProvider" $.Values.secretProvider "context" $ )  }}
```

___
Return to [Common components](./README.md)
