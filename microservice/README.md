
<p align="center">
<a href="https://github.com/carlosrfjunior/helm-charts">
<image src="https://avatars.githubusercontent.com/u/180111812?s=400&u=cda6d53ade890c5d47426504081e4fcb1167199d&v=4" style="width: 300px;">
</a>
</p>

# microservice

![Version: 1.0.0](https://img.shields.io/badge/Version-1.0.0-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

Microservice Helm Chart bundle

**Homepage:** <https://github.com/carlosrfjunior>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| carlosrfjunior | <infra@company.com> | <https://www.company.com> |

## Source Code

* <https://github.com/carlosrfjunior/helm-charts>

## References

- <https://github.com/helm/charts/blob/master/incubator/common>
- <https://github.com/bitnami/charts/blob/common>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| file://../common | common | 1.0.0 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Affinity for pod assignment more information can be found here: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity |
| autoscaling.enabled | bool | `false` | This sets the autoscaling enabled. |
| autoscaling.maxReplicas | int | `100` | This sets the maximum replicas. |
| autoscaling.minReplicas | int | `1` | This sets the minimum replicas. |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | This sets the target CPU utilization percentage. |
| fullnameOverride | string | `""` | This is to override the chart fullname. |
| image.pullPolicy | string | `"IfNotPresent"` | This sets the pull policy for images. |
| image.repository | string | `"ubuntu"` | This sets the image repository. |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` | This is for the secretes for pulling an image from a private repository more information can be found here: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| ingress | list | `[]` | This block is for setting up the ingress for more information can be found here: https://kubernetes.io/docs/concepts/services-networking/ingress/ |
| jobs | list | `[]` | This block is for setting up the jobs for more information can be found here: https://kubernetes.io/docs/concepts/workloads/controllers/jobs-run-to-completion/ |
| livenessProbe.httpGet.path | string | `"/"` | This sets the path for the liveness probe. |
| livenessProbe.httpGet.port | string | `"http"` | This sets the port for the liveness probe. |
| nameOverride | string | `""` | This is to override the chart name. |
| nodeSelector | object | `{}` | Node Selector labels for pod assignment more information can be found here: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector |
| podAnnotations | object | `{}` | This is for setting Kubernetes Annotations to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/annotations/ |
| podLabels | object | `{}` | This is for setting Kubernetes Labels to a Pod. For more information checkout: https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/ |
| podSecurityContext | object | `{}` | This is for setting the pod security context more information can be found here: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/ |
| readinessProbe.httpGet.path | string | `"/"` | This sets the path for the readiness probe. |
| readinessProbe.httpGet.port | string | `"http"` | This sets the port for the readiness probe. |
| replicaCount | int | `1` | This will set the replicaset count more information can be found here: https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/ |
| resources | object | `{}` | This is for setting up the resources more information can be found here: https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/ |
| secretProvider | list | `[]` | Additional Secret Provider for the output Deployment definition. |
| securityContext | object | `{}` | This is for setting the container security context more information can be found here: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/ |
| service.port | int | `80` | This sets the ports more information can be found here: https://kubernetes.io/docs/concepts/services-networking/service/#field-spec-ports |
| service.type | string | `"ClusterIP"` | This sets the service type more information can be found here: https://kubernetes.io/docs/concepts/services-networking/service/#publishing-services-service-types |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` | Toleration labels for pod assignment more information can be found here: https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/ |
| volumeMounts | list | `[]` | Additional volumeMounts on the output Deployment definition. |
| volumes | list | `[]` | Additional volumes on the output Deployment definition. |
