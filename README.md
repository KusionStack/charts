## Usage

[Helm](https://helm.sh) must be installed to use the charts.  Please refer to
Helm's [documentation](https://helm.sh/docs) to get started.

Once Helm has been set up correctly, add the repo as follows:

```bash
$ helm repo add kusionstack https://kusionstack.github.io/charts
```

If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo <alias>` to see the charts.

To install the `chart-name` chart:

```bash
$ helm install chart-name kusionstack/chart-name
```

To uninstall the chart:

```bash
$ helm delete chart-name
```