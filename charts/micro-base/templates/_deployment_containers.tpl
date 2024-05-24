{{- define "micro-base.deployment_containers" -}}
    containers:
      - name: {{ template "micro-base.fullname" . }}
        image: "{{ .Values.deployment.image.repository }}:{{ .Values.deployment.image.tag }}"
        imagePullPolicy: {{ .Values.deployment.image.pullPolicy }}
        {{- if .Values.deployment.command }}
        command:
        {{- range .Values.deployment.command }}
        - {{ . | quote }}
        {{- end }}
        {{- end }}
        {{- if .Values.deployment.args }}
        args:
        {{- range .Values.deployment.args }}
        - {{ . | quote }}
        {{- end }}
        {{- end }}
        {{- if .Values.deployment.env }}
        env: {{ toYaml .Values.deployment.env | nindent 8 }}
        {{- end }}
        ports: {{ toYaml .Values.deployment.ports | nindent 8 }}
        {{- if .Values.deployment.volumeMounts }}
        volumeMounts: {{ toYaml .Values.deployment.volumeMounts | nindent 8 }}
        {{- end }}
        {{ include "micro-base.deployment_probes" . }}
{{- end }}