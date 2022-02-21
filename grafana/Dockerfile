FROM grafana/grafana:8.2.6

COPY datasources.yml   /etc/grafana/provisioning/datasources/
COPY dashboards/*.yml  /etc/grafana/provisioning/dashboards/
COPY dashboards/*.json /var/lib/grafana/dashboards/

ENV POSTGRES_URL="localhost:5432"
ENV POSTGRES_DB="postgres"
ENV POSTGRES_USER="grafana"
ENV POSTGRES_SSL_MODE="disable"
ENV GF_DASHBOARDS_MIN_REFRESH_INTERVAL="1s"
ENV GF_DASHBOARDS_DEFAULT_HOME_DASHBOARD_PATH="/var/lib/grafana/dashboards/home.json"

ENV PROMETHEUS_URL="http://localhost:9090"
