{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "karpor.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "karpor.labels" -}}
helm.sh/chart: {{ include "karpor.chart" .context }}
{{ include "karpor.selectorLabels" (dict "context" .context "component" .component) }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
app.kubernetes.io/version: {{ .context.Chart.AppVersion }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "karpor.selectorLabels" -}}
app.kubernetes.io/name: {{ .context.Chart.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end }}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- end }}

{{/*
Real image.
*/}}
{{- define "karpor.realImage" -}}
{{- trimPrefix "/" (list (trimAll "/" .context.Values.registryProxy)
.repo | join "/") }}:{{ if .needV }}v{{ end }}{{ default .context.Chart.AppVersion .tag }}
{{- end -}}

{{/*
ElasticSearch URL.
*/}}
{{- define "elasticsearch.url" -}}
{{ if .Values.search.external.enabled }}{{ .Values.search.external.addresses | join "," }}{{else}}http://elasticsearch.{{ .Values.namespace }}.svc:{{ .Values.elasticsearch.port }}{{end}}
{{- end -}}

{{/*
Meilisearch URL.
*/}}
{{- define "meilisearch.url" -}}
{{ if .Values.search.external.enabled }}{{ .Values.search.external.addresses | join "," }}{{else}}http://meilisearch.{{ .Values.namespace }}.svc:{{ .Values.meilisearch.port }}{{end}}
{{- end -}}



{{/*
Search URL Args.
*/}}
{{- define "karpor.searchURL" -}}
{{ if eq .Values.search.engine "meilisearch" }}{{ include "meilisearch.url" .}}{{else}}{{ include "elasticsearch.url" . }}{{ end }}
{{- end -}}

{{/*
Search User Args.
*/}}
{{- define "karpor.searchUsername" -}}
{{ if  eq .Values.search.engine "meilisearch" }}{{ include "meilisearch.user" . }}{{else}}{{ include "elasticsearch.user" . }}{{ end }}
{{- end -}}

{{/*
Search Password Args.
*/}}
{{- define "karpor.searchPassword" -}}
{{ if  eq  .Values.search.engine "meilisearch" }}{{ include "meilisearch.password" . }}{{else}}{{ include "elasticsearch.password" . }}{{ end }}
{{- end -}}

{{/*
Meilisearch User.
*/}}
{{- define "meilisearch.user" -}}
{{ if .Values.search.external.enabled }}{{ .Values.search.external.username }}{{else}} {{ "" }}{{end}}
{{- end -}}

{{/*
Meilisearch Password.
*/}}
{{- define "meilisearch.password" -}}
{{ if .Values.search.external.enabled }}{{ .Values.search.external.password }}{{else}}{{ .Values.meilisearch.key }}{{end}}
{{- end -}}

{{/*
ElasticSearch User.
*/}}
{{- define "elasticsearch.user" -}}
{{ if .Values.search.external.enabled }}{{ .Values.search.external.username }}{{else}}{{ "" }}{{end}}
{{- end -}}

{{/*
ElasticSearch Password.
*/}}
{{- define "elasticsearch.password" -}}
{{ if .Values.search.external.enabled }}{{ .Values.search.external.password }}{{else}}{{ "" }}{{end}}
{{- end -}}



