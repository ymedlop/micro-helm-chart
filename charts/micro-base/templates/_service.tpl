{{- define "micro-base.service" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ template "micro-base.fullname" . }}
  labels:
    app.kubernetes.io/name: {{ template "micro-base.fullname" $ }}
    app.kubernetes.io/instance: {{ template "micro-base.fullname" $ }}
    app.kubernetes.io/version: {{ .Values.deployment.image.tag }}
    app.kubernetes.io/managed-by: helm
    app: {{ template "micro-base.fullname" . }}
    chart: "{{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}"
    runtime: {{ .Values.runtime }}
spec:
  type: {{ .Values.service.type | default "ClusterIP" }}
  ports:
  {{- range $name, $value := .Values.service.ports }}
    - name: {{ $value.name | quote }}
      port: {{ int $value.port }}
      protocol: {{ $value.protocol | default "TCP" | quote }}
      targetPort: {{ $value.targetPort | default $value.name | quote }}
  {{- end }}
  selector:
    app: {{ template "micro-base.fullname" . }}
{{- end }}