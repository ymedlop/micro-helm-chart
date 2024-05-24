{{- define "micro-base.configmap" -}}
{{- if .Values.configmap -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Values.configmap.name }}
  labels:
    app.kubernetes.io/name: {{ .Values.configmap.name }}
    app.kubernetes.io/instance: {{ template "micro-base.fullname" $ }}
    app.kubernetes.io/version: {{ .Values.deployment.image.tag }}
    app.kubernetes.io/managed-by: helm
    app_name: {{ template "micro-base.fullname" . }}
    chart: "{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}"
    runtime: {{ .Values.runtime }}
data:
{{ toYaml .Values.configmap.data | indent 2 }}
{{- end }}
{{- end }}