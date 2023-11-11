# Prometheus Kafka Exporter

A Prometheus exporter for [Apacher Kafka](https://kafka.apache.org/) metrics.

This chart bootstraps a [Kafka Exporter](https://github.com/danielqsj/kafka_exporter) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.19+
- Helm 3

Helm v2 is no longer supported from chart version 2.0.0.

## Get Repository Info

```console
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
```

_See [helm repo](https://helm.sh/docs/helm/helm_repo/) for command documentation._

## Install Chart

```console
helm dependency build
helm install [RELEASE_NAME] prometheus-community/prometheus-kafka-exporter
```

_See [configuration](#configuration) below._

_See [helm install](https://helm.sh/docs/helm/helm_install/) for command documentation._

## Uninstall Chart

```console
helm uninstall [RELEASE_NAME]
```

This removes all the Kubernetes components associated with the chart and deletes the release.

_See [helm uninstall](https://helm.sh/docs/helm/helm_uninstall/) for command documentation._

## Upgrading Chart

```console
helm upgrade [RELEASE_NAME] prometheus-community/prometheus-kafka-exporter --install
```

## To 3.0

In release 3.0, labels and selectors have been replaced following [Helm 3 label and annotation best practices](https://helm.sh/docs/chart_best_practices/labels/):

| Previous            | Current                      |
|---------------------|------------------------------|
| app                 | app.kubernetes.io/name       |
| chart               | helm.sh/chart                |
| [none]              | app.kubernetes.io/version    |
| heritage            | app.kubernetes.io/managed-by |
| release             | app.kubernetes.io/instance   |

As the change is affecting immutable selector labels, the deployment must be deleted before upgrading the release:

```console
kubectl delete deploy -l app=prometheus-kafka-exporter
```

Once the resources have been deleted, you can upgrade the release:

```console
helm upgrade -i RELEASE_NAME prometheus-community/prometheus-kafka-exporter
```

Field `annotations` that has been applied to pod's annotations has been replaced with `pod.annotations`. If you previously set annotations by means of that field, please, use the new one instead.

_See [helm upgrade](https://helm.sh/docs/helm/helm_upgrade/) for command documentation._

## Configuration

See [Customizing the Chart Before Installing](https://helm.sh/docs/intro/using_helm/#customizing-the-chart-before-installing). To see all configurable options with detailed comments, visit the chart's [values.yaml](https://github.com/prometheus-community/helm-charts/tree/main/charts/prometheus-kafka-exporter/values.yaml), or run these configuration commands:

```console
helm show values prometheus-community/prometheus-kafka-exporter
```
