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
  metrics_path: {{ $.Values.server.prefixURL }}{{ default .metricsPath .prometheusConfig.metricsPath }}
  scheme: {{ default .scheme .prometheusConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .prometheusConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .prometheusConfig.scrapeTimeout }}
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
  {{- with .prometheusConfig.staticConfigs }}
  static_configs:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}

{{- if .apiserversConfig.enabled }}
- job_name: "{{ .apiserversConfig.jobName }}"
  honor_labels: {{ default .honorLabels .apiserversConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .apiserversConfig.metricsPath }}
  scheme: {{ default .scheme .apiserversConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .apiserversConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .apiserversConfig.scrapeTimeout }}
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
  {{- with .apiserversConfig.kubernetesSDConfigs }}
  kubernetes_sd_configs:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}

{{- if .nodesConfig.enabled }}
- job_name: "{{ .nodesConfig.jobName }}"
  honor_labels: {{ default .honorLabels .nodesConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .nodesConfig.metricsPath }}
  scheme: {{ default .scheme .nodesConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .nodesConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .nodesConfig.scrapeTimeout }}
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
  {{- with .nodesConfig.kubernetesSDConfigs }}
  kubernetes_sd_configs:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}

{{- if .nodesCadvisorConfig.enabled }}
- job_name: "{{ .nodesCadvisorConfig.jobName }}"
  honor_labels: {{ default .honorLabels .nodesCadvisorConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .nodesCadvisorConfig.metricsPath }}
  scheme: {{ default .scheme .nodesCadvisorConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .nodesCadvisorConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .nodesCadvisorConfig.scrapeTimeout }}
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
  {{- with .nodesCadvisorConfig.kubernetesSDConfigs }}
  kubernetes_sd_configs:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}

{{- if .serviceEndpointsConfig.enabled }}
- job_name: "{{ .serviceEndpointsConfig.jobName }}"
  honor_labels: {{ default .honorLabels .serviceEndpointsConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .serviceEndpointsConfig.metricsPath }}
  scheme: {{ default .scheme .serviceEndpointsConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .serviceEndpointsConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .serviceEndpointsConfig.scrapeTimeout }}
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
  {{- with .serviceEndpointsConfig.kubernetesSDConfigs }}
  kubernetes_sd_configs:
    {{- toYaml . | nindent 4 }}
    {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
    {{- end }}
  {{- end }}
{{- end }}

{{- if .serviceEndpointsSlowConfig.enabled }}
- job_name: "{{ .serviceEndpointsSlowConfig.jobName }}"
  honor_labels: {{ default .honorLabels .serviceEndpointsSlowConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .serviceEndpointsSlowConfig.metricsPath }}
  scheme: {{ default .scheme .serviceEndpointsSlowConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .serviceEndpointsSlowConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .serviceEndpointsSlowConfig.scrapeTimeout }}
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
  {{- with .serviceEndpointsSlowConfig.kubernetesSDConfigs }}
  kubernetes_sd_configs:
    {{- toYaml . | nindent 4 }}
    {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
    {{- end }}
  {{- end }}
{{- end }}

{{- if .pushgatewayConfig.enabled }}
- job_name: "{{ .pushgatewayConfig.jobName }}"
  honor_labels: {{ default .honorLabels .pushgatewayConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .pushgatewayConfig.metricsPath }}
  scheme: {{ default .scheme .pushgatewayConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .pushgatewayConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .pushgatewayConfig.scrapeTimeout }}
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
  {{- with .pushgatewayConfig.kubernetesSDConfigs }}
  kubernetes_sd_configs:
    {{- toYaml . | nindent 4 }}
    {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
    {{- end }}
  {{- end }}
{{- end }}

{{- if .servicesConfig.enabled }}
- job_name: "{{ .servicesConfig.jobName }}"
  honor_labels: {{ default .honorLabels .servicesConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .servicesConfig.metricsPath }}
  scheme: {{ default .scheme .servicesConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .servicesConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .servicesConfig.scrapeTimeout }}
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
  {{- with .servicesConfig.kubernetesSDConfigs }}
  kubernetes_sd_configs:
    {{- toYaml . | nindent 4 }}
    {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
    {{- end }}
  {{- end }}
{{- end }}

{{- if .podsConfig.enabled }}
- job_name: "{{ .podsConfig.jobName }}"
  honor_labels: {{ default .honorLabels .podsConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .podsConfig.metricsPath }}
  scheme: {{ default .scheme .podsConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .podsConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .podsConfig.scrapeTimeout }}
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
  {{- with .podsConfig.kubernetesSDConfigs }}
  kubernetes_sd_configs:
    {{- toYaml . | nindent 4 }}
    {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
    {{- end }}
  {{- end }}
{{- end }}

{{- if .podsSlowConfig.enabled }}
- job_name: "{{ .podsSlowConfig.jobName }}"
  honor_labels: {{ default .honorLabels .podsSlowConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .podsSlowConfig.metricsPath }}
  scheme: {{ default .scheme .podsSlowConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .podsSlowConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .podsSlowConfig.scrapeTimeout }}
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
  {{- with .podsSlowConfig.kubernetesSDConfigs }}
  kubernetes_sd_configs:
    {{- toYaml . | nindent 4 }}
    {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
    {{- end }}
  {{- end }}
{{- end }}

{{- if .ingressesConfig.enabled }}
- job_name: "{{ .ingressesConfig.jobName }}"
  honor_labels: {{ default .honorLabels .ingressesConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .ingressesConfig.metricsPath }}
  scheme: {{ default .scheme .ingressesConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .ingressesConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .ingressesConfig.scrapeTimeout }}
  {{- with .ingressesConfig.basicAuth }}
  basic_auth: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .ingressesConfig.params }}
  params: {{ toYaml . | nindent 4 }}
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
  {{- with .ingressesConfig.kubernetesSDConfigs }}
  kubernetes_sd_configs:
    {{- toYaml . | nindent 4 }}
    {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}
{{- end }}