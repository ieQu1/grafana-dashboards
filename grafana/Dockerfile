FROM grafana/grafana:latest

COPY datasources.yml   /etc/grafana/provisioning/datasources/
COPY dashboards/*.yml  /etc/grafana/provisioning/dashboards/
COPY dashboards/*.json /var/lib/grafana/dashboards/

ENV POSTGRES_URL="localhost:5432"
ENV POSTGRES_DB="postgres"
ENV POSTGRES_USER="grafana"
ENV POSTGRES_SSL_MODE="disable"

ENV PROMETHEUS_URL="http://localhost:9090"
