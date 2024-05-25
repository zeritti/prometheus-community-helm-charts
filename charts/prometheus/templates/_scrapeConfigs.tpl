{{/*
Define default scrape configs template
*/}}

{{- define "prometheus.scrapeConfigs" -}}
{{- $namespaces := list -}}
{{- $namespaces = (include "prometheus.namespaces" . | fromJsonArray | mustUniq) -}}

{{- with .Values.scrapeConfigs }}
{{- if .prometheusScrapeConfig.enabled }}
- job_name: "{{ .prometheusScrapeConfig.jobName }}"
  honor_labels: {{ default .honorLabels .prometheusScrapeConfig.honorLabels }}
  metrics_path: {{ $.Values.server.prefixURL }}{{ default .metricsPath .prometheusScrapeConfig.metricsPath }}
  scheme: {{ default .scheme .prometheusScrapeConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .prometheusScrapeConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .prometheusScrapeConfig.scrapeTimeout }}
  {{- with .prometheusScrapeConfig.basicAuth }}
  basic_auth: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .prometheusScrapeConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .prometheusScrapeConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .prometheusScrapeConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .prometheusScrapeConfig.staticConfigs }}
  static_configs:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}

{{- if .apiserversScrapeConfig.enabled }}
- job_name: "{{ .apiserversScrapeConfig.jobName }}"
  honor_labels: {{ default .honorLabels .apiserversScrapeConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .apiserversScrapeConfig.metricsPath }}
  scheme: {{ default .scheme .apiserversScrapeConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .apiserversScrapeConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .apiserversScrapeConfig.scrapeTimeout }}
  {{- with .apiserversScrapeConfig.authorization }}
  authorization: {{ toYaml . | nindent 4 }}
  {{- end}}
  {{- with .apiserversScrapeConfig.tlsConfig }}
  tls_scrapeConfig: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .apiserversScrapeConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .apiserversScrapeConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .apiserversScrapeConfig.kubernetesSDConfigs }}
  kubernetes_sd_configs:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}

{{- if .nodesScrapeConfig.enabled }}
- job_name: "{{ .nodesScrapeConfig.jobName }}"
  honor_labels: {{ default .honorLabels .nodesScrapeConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .nodesScrapeConfig.metricsPath }}
  scheme: {{ default .scheme .nodesScrapeConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .nodesScrapeConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .nodesScrapeConfig.scrapeTimeout }}
  {{- with .nodesScrapeConfig.authorization }}
  authorization: {{ toYaml . | nindent 4 }}
  {{- end}}
  {{- with .nodesScrapeConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .nodesScrapeConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .nodesScrapeConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .nodesScrapeConfig.kubernetesSDConfigs }}
  kubernetes_sd_configs:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}

{{- if .nodesCadvisorScrapeConfig.enabled }}
- job_name: "{{ .nodesCadvisorScrapeConfig.jobName }}"
  honor_labels: {{ default .honorLabels .nodesCadvisorScrapeConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .nodesCadvisorScrapeConfig.metricsPath }}
  scheme: {{ default .scheme .nodesCadvisorScrapeConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .nodesCadvisorScrapeConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .nodesCadvisorScrapeConfig.scrapeTimeout }}
  {{- with .nodesCadvisorScrapeConfig.authorization }}
  authorization: {{ toYaml . | nindent 4 }}
  {{- end}}
  {{- with .nodesCadvisorScrapeConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .nodesCadvisorScrapeConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .nodesCadvisorScrapeConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .nodesCadvisorScrapeConfig.kubernetesSDConfigs }}
  kubernetes_sd_configs:
    {{- toYaml . | nindent 4 }}
  {{- end }}
{{- end }}

{{- if .serviceEndpointsScrapeConfig.enabled }}
- job_name: "{{ .serviceEndpointsScrapeConfig.jobName }}"
  honor_labels: {{ default .honorLabels .serviceEndpointsScrapeConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .serviceEndpointsScrapeConfig.metricsPath }}
  scheme: {{ default .scheme .serviceEndpointsScrapeConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .serviceEndpointsScrapeConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .serviceEndpointsScrapeConfig.scrapeTimeout }}
  {{- with .serviceEndpointsScrapeConfig.basicAuth }}
  basic_auth: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .serviceEndpointsScrapeConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .serviceEndpointsScrapeConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .serviceEndpointsScrapeConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .serviceEndpointsScrapeConfig.kubernetesSDConfigs }}
  kubernetes_sd_configs:
    {{- toYaml . | nindent 4 }}
    {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
    {{- end }}
  {{- end }}
{{- end }}

{{- if .serviceEndpointsSlowScrapeConfig.enabled }}
- job_name: "{{ .serviceEndpointsSlowScrapeConfig.jobName }}"
  honor_labels: {{ default .honorLabels .serviceEndpointsSlowScrapeConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .serviceEndpointsSlowScrapeConfig.metricsPath }}
  scheme: {{ default .scheme .serviceEndpointsSlowScrapeConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .serviceEndpointsSlowScrapeConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .serviceEndpointsSlowScrapeConfig.scrapeTimeout }}
  {{- with .serviceEndpointsSlowScrapeConfig.basicAuth }}
  basic_auth: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .serviceEndpointsSlowScrapeConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .serviceEndpointsSlowScrapeConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .serviceEndpointsSlowScrapeConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .serviceEndpointsSlowScrapeConfig.kubernetesSDConfigs }}
  kubernetes_sd_configs:
    {{- toYaml . | nindent 4 }}
    {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
    {{- end }}
  {{- end }}
{{- end }}

{{- if .pushgatewayScrapeConfig.enabled }}
- job_name: "{{ .pushgatewayScrapeConfig.jobName }}"
  honor_labels: {{ default .honorLabels .pushgatewayScrapeConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .pushgatewayScrapeConfig.metricsPath }}
  scheme: {{ default .scheme .pushgatewayScrapeConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .pushgatewayScrapeConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .pushgatewayScrapeConfig.scrapeTimeout }}
  {{- with .pushgatewayScrapeConfig.basicAuth }}
  basic_auth: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .pushgatewayScrapeConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .pushgatewayScrapeConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .pushgatewayScrapeConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .pushgatewayScrapeConfig.kubernetesSDConfigs }}
  kubernetes_sd_configs:
    {{- toYaml . | nindent 4 }}
    {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
    {{- end }}
  {{- end }}
{{- end }}

{{- if .servicesScrapeConfig.enabled }}
- job_name: "{{ .servicesScrapeConfig.jobName }}"
  honor_labels: {{ default .honorLabels .servicesScrapeConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .servicesScrapeConfig.metricsPath }}
  scheme: {{ default .scheme .servicesScrapeConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .servicesScrapeConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .servicesScrapeConfig.scrapeTimeout }}
  {{- with .servicesScrapeConfig.params }}
  params: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .servicesScrapeConfig.basicAuth }}
  basic_auth: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .servicesScrapeConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .servicesScrapeConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .servicesScrapeConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .servicesScrapeConfig.kubernetesSDConfigs }}
  kubernetes_sd_configs:
    {{- toYaml . | nindent 4 }}
    {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
    {{- end }}
  {{- end }}
{{- end }}

{{- if .podsScrapeConfig.enabled }}
- job_name: "{{ .podsScrapeConfig.jobName }}"
  honor_labels: {{ default .honorLabels .podsScrapeConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .podsScrapeConfig.metricsPath }}
  scheme: {{ default .scheme .podsScrapeConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .podsScrapeConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .podsScrapeConfig.scrapeTimeout }}
  {{- with .podsScrapeConfig.basicAuth }}
  basic_auth: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .podsScrapeConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .podsScrapeConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .podsScrapeConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .podsScrapeConfig.kubernetesSDConfigs }}
  kubernetes_sd_configs:
    {{- toYaml . | nindent 4 }}
    {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
    {{- end }}
  {{- end }}
{{- end }}

{{- if .podsSlowScrapeConfig.enabled }}
- job_name: "{{ .podsSlowScrapeConfig.jobName }}"
  honor_labels: {{ default .honorLabels .podsSlowScrapeConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .podsSlowScrapeConfig.metricsPath }}
  scheme: {{ default .scheme .podsSlowScrapeConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .podsSlowScrapeConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .podsSlowScrapeConfig.scrapeTimeout }}
  {{- with .podsSlowScrapeConfig.basicAuth }}
  basic_auth: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .podsSlowScrapeConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .podsSlowScrapeConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .podsSlowScrapeConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .podsSlowScrapeConfig.kubernetesSDConfigs }}
  kubernetes_sd_configs:
    {{- toYaml . | nindent 4 }}
    {{- if $namespaces }}
      namespaces:
        names: {{ toYaml $namespaces | nindent 10 }}
    {{- end }}
  {{- end }}
{{- end }}

{{- if .ingressesScrapeConfig.enabled }}
- job_name: "{{ .ingressesScrapeConfig.jobName }}"
  honor_labels: {{ default .honorLabels .ingressesScrapeConfig.honorLabels }}
  metrics_path: {{ default .metricsPath .ingressesScrapeConfig.metricsPath }}
  scheme: {{ default .scheme .ingressesScrapeConfig.scheme }}
  scrape_interval: {{ default .scrapeInterval .ingressesScrapeConfig.scrapeInterval }}
  scrape_timeout: {{ default .scrapeTimeout .ingressesScrapeConfig.scrapeTimeout }}
  {{- with .ingressesScrapeConfig.basicAuth }}
  basic_auth: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .ingressesScrapeConfig.params }}
  params: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .ingressesScrapeConfig.tlsConfig }}
  tls_config: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .ingressesScrapeConfig.metricRelabelings }}
  metric_relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .ingressesScrapeConfig.relabelings }}
  relabel_configs: {{ toYaml . | nindent 4 }}
  {{- end }}
  {{- with .ingressesScrapeConfig.kubernetesSDConfigs }}
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
