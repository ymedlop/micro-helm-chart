{{- define "micro-base.deployment" -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ template "micro-base.fullname" . }}
  labels:
    app: {{ template "micro-base.fullname" . }}
    chart: "{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}"
    runtime: {{ .Values.runtime }}
spec:
  # Hotfix: HPA with GitOPS
  # URL: https://github.com/argoproj/argo-cd/discussions/5105#discussioncomment-235617
  {{- if not .Values.hpa.enabled }}
  replicas: {{ .Values.deployment.replicas }}
  {{- end }}
  selector:
    matchLabels:
      app: {{ template "micro-base.fullname" . }}
  template:
    metadata:
      labels:
        app: {{ template "micro-base.fullname" . }}
        chart: "{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}"
        runtime: {{ .Values.runtime }}
    spec:
      {{- if .Values.deployment.serviceAccountName }}
      serviceAccountName: {{ .Values.deployment.serviceAccountName }}
      {{- end }}
      # containers
      {{ include "micro-base.deployment_containers" . }}

{{- end }}