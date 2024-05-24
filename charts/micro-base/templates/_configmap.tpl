{{- define "micro-base.configmap" -}}
{{- if .Values.configmap -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ template "micro-base.fullname" . }}
  labels:
    app.kubernetes.io/name: {{ template "micro-base.fullname" $ }}
    app.kubernetes.io/instance: {{ template "micro-base.fullname" $ }}
    app.kubernetes.io/version: {{ .Values.deployment.image.tag }}
    app.kubernetes.io/managed-by: helm
    app_name: {{ template "micro-base.fullname" . }}
    chart: "{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}"
    runtime: {{ .Values.runtime }}
data:
{{- range $itemName, $itemValue := .Values.configmap.data -}}
    {{ $itemName | quote }}: {{ $itemValue | quote }}
{{- end }}
{{- end }}
{{- end }}