# Kusion Chart

![Version: 0.14.2](https://img.shields.io/badge/Version-0.14.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.14.0](https://img.shields.io/badge/AppVersion-0.14.0-informational?style=flat-square)  [![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/kusion)](https://artifacthub.io/packages/helm/kusionstack/kusion)

Kusion - An Intent-Driven Platform Orchestrator

**Homepage:** <https://github.com/KusionStack/kusion>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| kusionstack | <kusionstack@gmail.com> | <https://kusionstack.io/docs> |

## Source Code

* <https://github.com/KusionStack/kusion>

## Prerequisites

- Helm v3+

## Installing the Chart

> **Important:** Kusion requires a valid kubeconfig configuration to function properly. You can provide it via:
> - Installation script (recommended)
> - Custom values.yaml file
> - Helm --set parameter

> **Note:** Default kubeconfig path is `/var/run/secrets/kubernetes.io/kubeconfigs/`
> To use a different path, set `kubeconfig.kubeConfigVolumeMountPath` to your desired path.

To install Kusion, you have the following options:

### 1. Use the installation script (recommended)

```shell
./scripts/install-kusion-server.sh <kubeconfig_key1=kubeconfig_path1> <kubeconfig_key2=kubeconfig_path2> ...
```

**Parameters:**

- **kubeconfig_key**: The key for the kubeconfig file. It should be unique and not contain spaces.

- **kubeconfig_path**: The path to the kubeconfig file.

### 2. Manual installation with your own kubeconfig

Edit the [values file](values.yaml) to add your kubeconfig content

```yaml
# Replace the content below with your actual kubeconfig
kubeconfig:
  kubeConfigs:
    kubeconfig-0: |
      Please fill in your KubeConfig contents here.
    kubeconfig-1: |
      Please fill in your KubeConfig contents here.
```

Then install the chart with the custom values file:

```shell
helm install kusion-release ./kusion
```

### 3. Install with specific configurations

First, you need to base64 encode your kubeconfig files.

```shell
KUBECONFIG_CONTENT1=$(cat /path/to/your/kubeconfig-1 | base64 | tr -d '\n')
KUBECONFIG_CONTENT2=$(cat /path/to/your/kubeconfig-2 | base64 | tr -d '\n')
```

Then you can use the following command to install the latest version of Kusion.

```shell
helm install kusion-release kusionstack/kusion \
--set kubeconfig.kubeConfigs.kubeconfig-0="$KUBECONFIG_CONTENT1" \
--set kubeconfig.kubeConfigs.kubeconfig-1="$KUBECONFIG_CONTENT2"
```

You may also have to set your specific configurations if it is deployed into a production cluster, or you want to customize the chart configuration, such as `port`, `replicas`, `database` etc.

> All configurable parameters of the Kusion chart are detailed [here](#chart-parameters).

```shell
helm install kusion-release kusionstack/kusion \
--set server.port=8080 \
--set server.replicas=3 \
--set mysql.enabled=true \
--set mysql.database=kusion \
--set kubeconfig.kubeConfigs.kubeconfig-0="$KUBECONFIG_CONTENT1" \
--set kubeconfig.kubeConfigs.kubeconfig-1="$KUBECONFIG_CONTENT2"
```

## Chart Parameters

The following table lists the configurable parameters of the chart and their default values.

### General Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| namespace | string | `"kusion"` | Which namespace to be deployed |
| namespaceEnabled | bool | `true` | Whether to generate namespace |
| registryProxy | string | `""` | Image registry proxy will be the prefix as all component images |

### Global Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|

### Kusion Server

The Kusion Server Component is the main backend server that provides the core functionality and REST APIs.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| server.args.authEnabled | bool | `false` | Whether to enable authentication |
| server.args.authKeyType | string | `"RSA"` | Authentication key type |
| server.args.authWhitelist | list | `[]` | Authentication whitelist |
| server.args.autoMigrate | bool | `true` | Whether to enable automatic migration |
| server.args.dbHost | string | `""` | Database host |
| server.args.dbName | string | `""` | Database name |
| server.args.dbPassword | string | `""` | Database password |
| server.args.dbPort | int | `3306` | Database port |
| server.args.dbUser | string | `""` | Database user |
| server.args.defaultSourceRemote | string | `""` | Default source URL |
| server.args.logFilePath | string | `"/logs/kusion.log"` | Logging |
| server.args.maxAsyncBuffer | int | `100` | Maximum number of buffer zones during concurrent async executions including generate, preview, apply and destroy |
| server.args.maxAsyncConcurrent | int | `1` | Maximum number of concurrent async executions including generate, preview, apply and destroy |
| server.args.maxConcurrent | int | `10` | Maximum number of concurrent executions including preview, apply and destroy |
| server.args.migrateFile | string | `""` | Migration file path |
| server.env | list | `[]` | Additional environment variables for the server |
| server.image.imagePullPolicy | string | `"IfNotPresent"` | Image pull policy |
| server.image.repo | string | `"kusionstack/kusion"` | Repository for Kusion server image |
| server.image.tag | string | `""` | Tag for Kusion server image. Defaults to the chart's appVersion if not specified |
| server.name | string | `"kusion-server"` | Component name for kusion server |
| server.port | int | `80` | Port for kusion server |
| server.replicas | int | `1` | The number of kusion server pods to run |
| server.resources | object | `{"limits":{"cpu":"500m","memory":"1Gi"},"requests":{"cpu":"250m","memory":"256Mi"}}` | Resource limits and requests for the kusion server pods |
| server.serviceType | string | `"ClusterIP"` | Service type for the kusion server. The available type values list as ["ClusterIP"、"NodePort"、"LoadBalancer"]. |

### MySQL Database

The MySQL database is used to store Kusion's persistent data.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| mysql.database | string | `"kusion"` | MySQL database name |
| mysql.enabled | bool | `true` | Whether to enable MySQL deployment |
| mysql.image.imagePullPolicy | string | `"IfNotPresent"` | Image pull policy |
| mysql.image.repo | string | `"mysql"` | Repository for MySQL image |
| mysql.image.tag | string | `"8.0"` | Specific tag for MySQL image |
| mysql.name | string | `"mysql"` | Component name for MySQL |
| mysql.password | string | `""` | MySQL password |
| mysql.persistence.accessModes | list | `["ReadWriteOnce"]` | Access modes for MySQL PVC |
| mysql.persistence.size | string | `"10Gi"` | Size of MySQL persistent volume |
| mysql.persistence.storageClass | string | `""` | Storage class for MySQL PVC |
| mysql.port | int | `3306` | Port for MySQL |
| mysql.replicas | int | `1` | The number of MySQL pods to run |
| mysql.resources | object | `{"limits":{"cpu":"1000m","memory":"1Gi"},"requests":{"cpu":"250m","memory":"512Mi"}}` | Resource limits and requests for MySQL pods |
| mysql.rootPassword | string | `""` | MySQL root password |
| mysql.user | string | `"kusion"` | MySQL user |

### KubeConfig

The KubeConfig is used to store the KubeConfig files for the Kusion Server.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| kubeconfig.kubeConfigVolumeMountPath | string | `"/var/run/secrets/kubernetes.io/kubeconfigs/"` | Volume mount path for KubeConfig files |
| kubeconfig.kubeConfigs | object | `{}` | KubeConfig contents map |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs](https://github.com/norwoodj/helm-docs)