#!/bin/bash
set -euo pipefail

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    create user system_monitor with password '${POSTGRES_PASS_SYSMON}';
    create database system_monitor owner system_monitor;
    GRANT CREATE ON SCHEMA public TO system_monitor;

    create user grafana with password '${POSTGRES_PASS_GRAFANA}';
EOSQL
