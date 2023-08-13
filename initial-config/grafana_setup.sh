#!/bin/bash

echo "* Add Prometheus Datasource"
./shared/grafana_setup/add_prometheus_datasource.sh

echo "* Add Monitoring Dashboard"
./shared/grafana_setup/add_monitoring_dashboard.sh