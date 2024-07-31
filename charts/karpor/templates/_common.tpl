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

