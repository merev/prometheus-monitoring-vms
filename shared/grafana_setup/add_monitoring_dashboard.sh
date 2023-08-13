#!/bin/bash

echo "* Grafana URL and admin credentials set"
GRAFANA_URL="http://localhost:3000"
ADMIN_USERNAME="admin"
ADMIN_PASSWORD="admin"

echo "* Dashboard JSON file path set"
DASHBOARD_JSON_FILE="/shared/grafana_setup/infra_monitoring_dashboard.json"

echo " Log in and get session cookie"
SESSION_COOKIE=$(curl -c cookies.txt -s -X POST \
  -H "Content-Type: application/json" \
  -d "{\"user\":\"$ADMIN_USERNAME\",\"email\":\"\",\"password\":\"$ADMIN_PASSWORD\"}" \
  "$GRAFANA_URL/login")

echo "* Upload the dashboard JSON file using Grafana API with session cookie"
DASHBOARD_ID=$(curl -b cookies.txt -s -X POST \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  --data-binary "@$DASHBOARD_JSON_FILE" \
  "$GRAFANA_URL/api/dashboards/db" | jq -r '.id')

echo "* Clean up cookies file"
rm cookies.txt

echo "Dashboard imported with ID: $DASHBOARD_ID"
