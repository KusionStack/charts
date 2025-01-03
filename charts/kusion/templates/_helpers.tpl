{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kusion.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "kusion.labels" -}}
helm.sh/chart: {{ include "kusion.chart" .context }}
{{ include "kusion.selectorLabels" (dict "context" .context "component" .component) }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
app.kubernetes.io/version: {{ .context.Chart.AppVersion }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kusion.selectorLabels" -}}
app.kubernetes.io/name: {{ .context.Chart.Name }}
{{- if .component }}
app.kubernetes.io/component: {{ .component }}
{{- end }}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- end }}

{{/*
Real image
*/}}
{{- define "kusion.realImage" -}}
{{- trimPrefix "/" (list (trimAll "/" .context.Values.registryProxy)
.repo | join "/") }}:{{ if .needV }}v{{ end }}{{ default .context.Chart.AppVersion .tag }}
{{- end -}}