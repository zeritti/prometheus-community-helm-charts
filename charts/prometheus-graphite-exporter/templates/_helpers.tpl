{{/*
Expand the name of the chart.
*/}}
{{- define "prometheus-graphite-exporter.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "prometheus-graphite-exporter.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "prometheus-graphite-exporter.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "prometheus-graphite-exporter.labels" -}}
helm.sh/chart: {{ include "prometheus-graphite-exporter.chart" . }}
{{ include "prometheus-graphite-exporter.selectorLabels" . }}
app.kubernetes.io/version: {{ coalesce .Values.image.digest .Values.image.tag .Chart.AppVersion }}
{{- with .Values.commonLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "prometheus-graphite-exporter.selectorLabels" -}}
app.kubernetes.io/name: {{ include "prometheus-graphite-exporter.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "prometheus-graphite-exporter.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "prometheus-graphite-exporter.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Define overriding namespace
*/}}
{{- define "prometheus-graphite-exporter.namespace" -}}
  {{- if .Values.namespaceOverride -}}
    {{- .Values.namespaceOverride -}}
  {{- else -}}
    {{- .Release.Namespace -}}
  {{- end -}}
{{- end -}}

{{/*
Define image tag by attaching "v" to the application version
preferring to keep the application version according to its release
*/}}
{{- define "prometheus-graphite-exporter.imageTag" -}}
{{- if .Values.image.tag -}}
{{- .Values.image.tag -}}
{{- else -}}
{{- print "v" .Chart.AppVersion -}}
{{- end -}}
{{- end -}}

{{/*
Define webConfiguration for web-config file
*/}}
{{- define "prometheus-graphite-exporter.webConfiguration" -}}
basic_auth_users:
{{- range $k, $v := .Values.webConfiguration.basicAuthUsers }}
  {{ $k }}: {{ htpasswd "" $v | trimPrefix ":"}}
{{- end }}
{{- end }}

{{/*
Define Authorization
*/}}
{{- define "prometheus-graphite-exporter.authorization" -}}
{{- $users := keys .Values.webConfiguration.basicAuthUsers }}
{{- $user := first $users }}
{{- $password := index .Values.webConfiguration.basicAuthUsers $user }}
{{- $user }}:{{ $password }}
{{- end }}

{{/*
Define basicAuth
*/}}
{{- define "prometheus-graphite-exporter.basicAuth" -}}
{{- $users := keys .Values.webConfiguration.basicAuthUsers }}
{{- $user := first $users }}
{{- $password := index .Values.webConfiguration.basicAuthUsers $user -}}
user: {{ $user | b64enc | quote }}
password: {{ $password | b64enc | quote }}
{{- end }}
