{{- define "micro-base.deployment_probes" -}}
    {{- if .Values.deployment.readinessProbe.enabled }}
    readinessProbe:
        failureThreshold: {{ .Values.deployment.readinessProbe.failureThreshold }}
        httpGet:
          path: {{ .Values.deployment.readinessProbe.httpGet.path }}
          port: {{ .Values.deployment.readinessProbe.httpGet.port }}
          scheme: {{ .Values.deployment.readinessProbe.httpGet.scheme }}
        initialDelaySeconds: {{ .Values.deployment.readinessProbe.initialDelaySeconds }}
        periodSeconds: {{ .Values.deployment.readinessProbe.periodSeconds }}
        successThreshold: {{ .Values.deployment.readinessProbe.successThreshold }}
        timeoutSeconds: {{ .Values.deployment.readinessProbe.timeoutSeconds }}
    {{- end }}
    {{- if .Values.deployment.livenessProbe.enabled }}
    livenessProbe:
        failureThreshold: {{ .Values.deployment.livenessProbe.failureThreshold }}
        httpGet:
          path: {{ .Values.deployment.livenessProbe.httpGet.path }}
          port: {{ .Values.deployment.livenessProbe.httpGet.port }}
          scheme: {{ .Values.deployment.livenessProbe.httpGet.scheme }}
        initialDelaySeconds: {{ .Values.deployment.livenessProbe.initialDelaySeconds }}
        periodSeconds: {{ .Values.deployment.livenessProbe.periodSeconds }}
        successThreshold: {{ .Values.deployment.livenessProbe.successThreshold }}
        timeoutSeconds: {{ .Values.deployment.livenessProbe.timeoutSeconds }}
    {{- end }}
{{- end }}