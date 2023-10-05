{{/*
Define default scrape configs template
*/}}

{{- define "prometheus.scrapeConfigs" -}}
{{- $namespaces := list -}}
{{- $namespaces = (include "prometheus.namespaces" . | fromJsonArray | mustUniq) -}}

{{- with .Values.scrapeConfigs }}
{{- if .prometheusConfig.enabled }}
- job_name: "{{ .prometheusConfig.jobName }}"
  honor_labels: {{ default .honorLabels .prometheusConfig.honorLabels }}
  metrics_path: {{ $.Values.server.prefixURL }}{{ default .path .prometheusConfig.path }}
  scheme: {{ default .scheme .prometheusConfig.scheme }}
  scrape_interval: {{ default .interval .prometheusConfig.interval }}
  scrape_timeout: {{ default .timeout .prometheusConfig.timeout }}
  {{- with .prometheusConfig.basicAuth }}
  basic_auth: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .prometheusConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .prometheusConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .prometheusConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  static_configs:
    - targets:
      - localhost:9090
      {{- with .prometheusConfig.targetLabels }}
      labels: {{ toYaml . | nindent 8 }}
      {{- end }}
{{- end }}

{{- if .apiserversConfig.enabled }}
- job_name: "{{ .apiserversConfig.jobName }}"
  honor_labels: {{ default .honorLabels .apiserversConfig.honorLabels }}
  metrics_path: {{ default .path .apiserversConfig.path }}
  scheme: {{ default .scheme .apiserversConfig.scheme }}
  scrape_interval: {{ default .interval .apiserversConfig.interval }}
  scrape_timeout: {{ default .timeout .apiserversConfig.timeout }}
  {{- with .apiserversConfig.authorization }}
  authorization: {{ toYaml . | nindent 4 }}
  {{- end}}
  {{- with .apiserversConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .apiserversConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .apiserversConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  kubernetes_sd_configs:
    - role: endpoints
      attach_metadata:
        node: {{ default .attachMetadata .apiserversConfig.attachMetadata }}
{{- end }}

{{- if .nodesConfig.enabled }}
- job_name: "{{ .nodesConfig.jobName }}"
  honor_labels: {{ default .honorLabels .nodesConfig.honorLabels }}
  metrics_path: {{ default .path .nodesConfig.path }}
  scheme: {{ default .scheme .nodesConfig.scheme }}
  scrape_interval: {{ default .interval .nodesConfig.interval }}
  scrape_timeout: {{ default .timeout .nodesConfig.timeout }}
  {{- with .nodesConfig.authorization }}
  authorization: {{ toYaml . | nindent 4 }}
  {{- end}}
  {{- with .nodesConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .nodesConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .nodesConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  kubernetes_sd_configs:
    - role: node
{{- end }}

{{- if .nodesCadvisorConfig.enabled }}
- job_name: "{{ .nodesCadvisorConfig.jobName }}"
  honor_labels: {{ default .honorLabels .nodesCadvisorConfig.honorLabels }}
  metrics_path: {{ default .path .nodesCadvisorConfig.path }}
  scheme: {{ default .scheme .nodesCadvisorConfig.scheme }}
  scrape_interval: {{ default .interval .nodesCadvisorConfig.interval }}
  scrape_timeout: {{ default .timeout .nodesCadvisorConfig.timeout }}
  {{- with .nodesCadvisorConfig.authorization }}
  authorization: {{ toYaml . | nindent 4 }}
  {{- end}}
  {{- with .nodesCadvisorConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .nodesCadvisorConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .nodesCadvisorConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  kubernetes_sd_configs:
    - role: node
{{- end }}

{{- if .serviceEndpointsConfig.enabled }}
- job_name: "{{ .serviceEndpointsConfig.jobName }}"
  honor_labels: {{ default .honorLabels .serviceEndpointsConfig.honorLabels }}
  metrics_path: {{ default .path .serviceEndpointsConfig.path }}
  scheme: {{ default .scheme .serviceEndpointsConfig.scheme }}
  scrape_interval: {{ default .interval .serviceEndpointsConfig.interval }}
  scrape_timeout: {{ default .timeout .serviceEndpointsConfig.timeout }}
  {{- with .serviceEndpointsConfig.basicAuth }}
  basic_auth: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .serviceEndpointsConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .serviceEndpointsConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .serviceEndpointsConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  kubernetes_sd_configs:
    - role: endpoints
      attach_metadata:
        node: {{ default .attachMetadata .serviceEndpointsConfig.attachMetadata }}
      {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
      {{- end }}
{{- end }}

{{- if .serviceEndpointsSlowConfig.enabled }}
- job_name: "{{ .serviceEndpointsSlowConfig.jobName }}"
  honor_labels: {{ default .honorLabels .serviceEndpointsSlowConfig.honorLabels }}
  metrics_path: {{ default .path .serviceEndpointsSlowConfig.path }}
  scheme: {{ default .scheme .serviceEndpointsSlowConfig.scheme }}
  scrape_interval: {{ default .interval .serviceEndpointsSlowConfig.interval }}
  scrape_timeout: {{ default .timeout .serviceEndpointsSlowConfig.timeout }}
  {{- with .serviceEndpointsSlowConfig.basicAuth }}
  basic_auth: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .serviceEndpointsSlowConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .serviceEndpointsSlowConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .serviceEndpointsSlowConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  kubernetes_sd_configs:
    - role: endpoints
      attach_metadata:
        node: {{ default .attachMetadata .serviceEndpointsSlowConfig.attachMetadata }}
     {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
     {{- end }}
{{- end }}

{{- if .pushgatewayConfig.enabled }}
- job_name: "{{ .pushgatewayConfig.jobName }}"
  honor_labels: {{ default .honorLabels .pushgatewayConfig.honorLabels }}
  metrics_path: {{ default .path .pushgatewayConfig.path }}
  scheme: {{ default .scheme .pushgatewayConfig.scheme }}
  scrape_interval: {{ default .interval .pushgatewayConfig.interval }}
  scrape_timeout: {{ default .timeout .pushgatewayConfig.timeout }}
  {{- with .pushgatewayConfig.basicAuth }}
  basic_auth: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .pushgatewayConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .pushgatewayConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .pushgatewayConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  kubernetes_sd_configs:
    - role: service
      {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
      {{- end }}
{{- end }}

{{- if .servicesConfig.enabled }}
- job_name: "{{ .servicesConfig.jobName }}"
  honor_labels: {{ default .honorLabels .servicesConfig.honorLabels }}
  metrics_path: {{ default .path .servicesConfig.path }}
  scheme: {{ default .scheme .servicesConfig.scheme }}
  scrape_interval: {{ default .interval .servicesConfig.interval }}
  scrape_timeout: {{ default .timeout .servicesConfig.timeout }}
  {{- with .servicesConfig.params }}
  params: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .servicesConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .servicesConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .servicesConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  kubernetes_sd_configs:
    - role: service
      {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
      {{- end }}
{{- end }}

{{- if .podsConfig.enabled }}
- job_name: "{{ .podsConfig.jobName }}"
  honor_labels: {{ default .honorLabels .podsConfig.honorLabels }}
  metrics_path: {{ default .path .podsConfig.path }}
  scheme: {{ default .scheme .podsConfig.scheme }}
  scrape_interval: {{ default .interval .podsConfig.interval }}
  scrape_timeout: {{ default .timeout .podsConfig.timeout }}
  {{- with .podsConfig.basicAuth }}
  basic_auth: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .podsConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .podsConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .podsConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  kubernetes_sd_configs:
    - role: pod
      attach_metadata:
        node: {{ default .attachMetadata .podsConfig.attachMetadata }}
      {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
      {{- end }}
{{- end }}

{{- if .podsSlowConfig.enabled }}
- job_name: "{{ .podsSlowConfig.jobName }}"
  honor_labels: {{ default .honorLabels .podsSlowConfig.honorLabels }}
  metrics_path: {{ default .path .podsSlowConfig.path }}
  scheme: {{ default .scheme .podsSlowConfig.scheme }}
  scrape_interval: {{ default .interval .podsSlowConfig.interval }}
  scrape_timeout: {{ default .timeout .podsSlowConfig.timeout }}
  {{- with .podsSlowConfig.basicAuth }}
  basic_auth: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .podsSlowConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .podsSlowConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .podsSlowConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  kubernetes_sd_configs:
    - role: pod
      attach_metadata:
        node: {{ default .attachMetadata .podsSlowConfig.attachMetadata }}
      {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
      {{- end }}
{{- end }}

{{- if .ingressesConfig.enabled }}
- job_name: "{{ .ingressesConfig.jobName }}"
  honor_labels: {{ default .honorLabels .ingressesConfig.honorLabels }}
  metrics_path: {{ default .path .ingressesConfig.path }}
  scheme: {{ default .scheme .ingressesConfig.scheme }}
  scrape_interval: {{ default .interval .ingressesConfig.interval }}
  {{- with .ingressesConfig.params }}
  params: {{ toYaml . | nindent 4 }}
  {{- end }}
  scrape_timeout: {{ default .timeout .ingressesConfig.timeout }}
  {{- with .ingressesConfig.basicAuth }}
  basic_auth: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .ingressesConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .ingressesConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .ingressesConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  kubernetes_sd_configs:
    - role: ingress
      {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
      {{- end }}
{{- end }}
{{- end }}
{{- end }}