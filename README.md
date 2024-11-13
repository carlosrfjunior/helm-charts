<p align="center">
<a href="https://github.com/carlosrfjunior/helm-charts">
<image src="https://avatars.githubusercontent.com/u/180111812?s=400&u=cda6d53ade890c5d47426504081e4fcb1167199d&v=4" style="width: 300px;">
</a>
</p>


# Helm Charts Repository


## How to use

[Helm](https://helm.sh) must be installed to use the charts.
Please refer to Helm's [Documentation](https://helm.sh/docs/) to get started.

After configuring the helm binary, add the repository to continue:

```console
helm repo add carlosrfjunior https://carlosrfjunior.github.io/helm-charts/
helm install microservice carlosrfjunior/microservice -f values.yaml
```

You can then run `helm search repo microservice` to see the charts.

Chart documentation is available in [Directory](https://github.com/carlosrfjunior/helm-charts/blob/main/README.md).

