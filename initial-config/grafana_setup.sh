#!/bin/bash

echo "* Add Prometheus Datasource"
bash /shared/grafana_setup/add_prometheus_datasource.sh

echo "* Add Monitoring Dashboard"
bash /shared/grafana_setup/add_monitoring_dashboard.sh
