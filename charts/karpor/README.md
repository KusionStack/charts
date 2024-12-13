# Karpor Chart

![Version: 0.6.16](https://img.shields.io/badge/Version-0.6.16-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.5.7](https://img.shields.io/badge/AppVersion-0.5.7-informational?style=flat-square)  [![Artifact HUB](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/karpor)](https://artifacthub.io/packages/helm/kusionstack/karpor)

A modern kubernetes visualization tool (Karpor).

**Homepage:** <https://github.com/KusionStack/karpor>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| kusionstack | <kusionstack@gmail.com> | <https://kusionstack.io/karpor> |

## Source Code

* <https://github.com/KusionStack/charts/tree/master/charts/karpor>
* <https://github.com/KusionStack/karpor>

## Prerequisites

- Helm v3+

## Installing the Chart

First, add the karpor chart repo to your local repository.

```shell
helm repo add kusionstack https://kusionstack.github.io/charts
helm repo update
```

Then you can use the following command to install the latest version of Karpor.

```shell
helm install karpor-release kusionstack/karpor
```

**Note** that installing this chart directly means it will use the [default template values](./values.yaml) for Karpor.

You may have to set your specific configurations if it is deployed into a production cluster, or you want to customize the chart configuration, such as `resources`, `replicas`, `port` etc.

All configurable parameters of the Karpor chart are detailed [here](#chart-parameters).

```shell
helm install karpor-release kusionstack/karpor --set server.replicas=3 --set syncer.port=7654
```

## Chart Parameters

The following table lists the configurable parameters of the chart and their default values.

### General Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| namespace | string | `"karpor"` | Which namespace to be deployed. |
| namespaceEnabled | bool | `true` | Whether to generate namespace. |
| registryProxy | string | `""` | Image registry proxy will be the prefix as all component image. |

### Global Parameters

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.image.imagePullPolicy | string | `"IfNotPresent"` | Image pull policy to be applied to all Karpor components. |

### Karpor Server

The Karpor Server Component is main backend server. It itself is an `apiserver`, which also provides `/rest-api` to serve Dashboard.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| server.image.repo | string | `"kusionstack/karpor"` | Repository for Karpor server image. |
| server.image.tag | string | `""` | Tag for Karpor server image. Defaults to the chart's appVersion if not specified. |
| server.name | string | `"karpor-server"` | Component name for karpor server. |
| server.port | int | `7443` | Port for karpor server. |
| server.replicas | int | `1` | The number of karpor server pods to run. |
| server.resources | object | `{"limits":{"cpu":"500m","ephemeral-storage":"10Gi","memory":"1Gi"},"requests":{"cpu":"250m","ephemeral-storage":"2Gi","memory":"256Mi"}}` | Resource limits and requests for the karpor server pods. |
| server.serviceType | string | `"ClusterIP"` | Service type for the karpor server. The available type values list as ["ClusterIP"、"NodePort"、"LoadBalancer"]. |

### Karpor Syncer

The Karpor Syncer Component is independent server to synchronize cluster resources in real-time.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| syncer.image.repo | string | `"kusionstack/karpor"` | Repository for Karpor syncer image. |
| syncer.image.tag | string | `""` | Tag for Karpor syncer image. Defaults to the chart's appVersion if not specified. |
| syncer.name | string | `"karpor-syncer"` | Component name for Karpor syncer. |
| syncer.port | int | `7443` | Port for Karpor syncer. |
| syncer.replicas | int | `1` | The number of karpor syncer pods to run. |
| syncer.resources | object | `{"limits":{"cpu":"500m","ephemeral-storage":"10Gi","memory":"1Gi"},"requests":{"cpu":"250m","ephemeral-storage":"2Gi","memory":"256Mi"}}` | Resource limits and requests for the karpor syncer pods. |

### ElasticSearch

The ElasticSearch Component to store the synchronized resources and user data.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| elasticsearch.image.repo | string | `"docker.elastic.co/elasticsearch/elasticsearch"` | Repository for ElasticSearch image. |
| elasticsearch.image.tag | string | `"8.6.2"` | Specific tag for ElasticSearch image. |
| elasticsearch.name | string | `"elasticsearch"` | Component name for ElasticSearch. |
| elasticsearch.port | int | `9200` | Port for ElasticSearch. |
| elasticsearch.replicas | int | `1` | The number of ElasticSearch pods to run. |
| elasticsearch.resources | object | `{"limits":{"cpu":"2","ephemeral-storage":"10Gi","memory":"4Gi"},"requests":{"cpu":"2","ephemeral-storage":"10Gi","memory":"4Gi"}}` | Resource limits and requests for the karpor elasticsearch pods. |

### ETCD

The ETCD Component is the storage of Karpor Server as `apiserver`.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| etcd.image.repo | string | `"quay.io/coreos/etcd"` | Repository for ETCD image. |
| etcd.image.tag | string | `"v3.5.11"` | Specific tag for ETCD image. |
| etcd.name | string | `"etcd"` | Component name for ETCD. |
| etcd.persistence.accessModes | list | `["ReadWriteOnce"]` | Volume access mode, ReadWriteOnce means single node read-write access |
| etcd.persistence.size | string | `"10Gi"` | Size of etcd persistent volume |
| etcd.port | int | `2379` | Port for ETCD. |
| etcd.replicas | int | `1` | The number of etcd pods to run. |
| etcd.resources | object | `{"limits":{"cpu":"500m","ephemeral-storage":"10Gi","memory":"1Gi"},"requests":{"cpu":"250m","ephemeral-storage":"2Gi","memory":"256Mi"}}` | Resource limits and requests for the karpor etcd pods. |

### Job

This one-time job is used to generate root certificates and some preliminary work.

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| job.image.repo | string | `"kusionstack/karpor"` | Repository for the Job image. |
| job.image.tag | string | `""` | Tag for Karpor image. Defaults to the chart's appVersion if not specified. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs](https://github.com/norwoodj/helm-docs)
