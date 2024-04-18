{{- define "micro-base.hpa" -}}
{{- if .Values.hpa.enabled -}}
# https://kubernetes.io/docs/reference/kubernetes-api/workload-resources/horizontal-pod-autoscaler-v2/
{{- if semverCompare ">=1.23.0-0" .Capabilities.KubeVersion.Version }}
apiVersion: autoscaling/v2
{{- else }}
apiVersion: autoscaling/v2beta2
{{- end }}
kind: HorizontalPodAutoscaler
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
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: {{ template "micro-base.fullname" . }}
  minReplicas: {{ .Values.hpa.minReplicas }}
  maxReplicas: {{ .Values.hpa.maxReplicas }}
  {{- if .Values.hpa.metrics }}
  metrics:
  {{ toYaml .Values.hpa.metrics | nindent 4 }}
  {{- end }}
  {{- if .Values.hpa.behavior }}
  behavior:
  {{ toYaml .Values.hpa.behavior | nindent 4 }}
  {{- end }}
{{- end }}
{{- end }}