#!/bin/bash

### Create connection ###

echo "* Grafana URL and admin credentials set"
GRAFANA_URL="http://localhost:3000"
ADMIN_USERNAME="admin"
ADMIN_PASSWORD="admin"


echo " Log in and get session cookie"
SESSION_COOKIE=$(curl -c cookies.txt -s -X POST \
  -H "Content-Type: application/json" \
  -d "{\"user\":\"$ADMIN_USERNAME\",\"email\":\"\",\"password\":\"$ADMIN_PASSWORD\"}" \
  "$GRAFANA_URL/login" | grep -oP '(?<=Set-Cookie: grafana_sess=)[^;]+')

#############################



### Add Prometheus Datasource ###

echo "* Prometheus data source configuration set"
DATASOURCE_NAME="Prometheus"
DATASOURCE_TYPE="prometheus"
DATASOURCE_URL="http://localhost:9090"
DATASOURCE_ACCESS="proxy"
DATASOURCE_IS_DEFAULT="true"

echo "* JSON payload for data source configuration generated"
PAYLOAD=$(cat <<EOF
{
  "name": "$DATASOURCE_NAME",
  "type": "$DATASOURCE_TYPE",
  "url": "$DATASOURCE_URL",
  "access": "$DATASOURCE_ACCESS",
  "isDefault": $DATASOURCE_IS_DEFAULT
}
EOF
)

echo " Add Prometheus data source using Grafana API with session cookie"
curl -b cookies.txt -s -X POST \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD" \
  "$GRAFANA_URL/api/datasources"

###################################



### Import Dashboard from JSON ###

echo "* Dashboard JSON file path set"
DASHBOARD_JSON_FILE="/shared/grafana_setup/infra_monitoring_dashboard.json"


echo "* Upload the dashboard JSON file using Grafana API with session cookie"
DASHBOARD_ID=$(curl -b cookies.txt -s -X POST \
  -H "Accept: application/json" \
  -H "Content-Type: application/json" \
  --data-binary "@$DASHBOARD_JSON_FILE" \
  "$GRAFANA_URL/api/dashboards/db" | jq -r '.id')

echo "* Clean up cookies file"
rm cookies.txt

echo "Dashboard imported with ID: $DASHBOARD_ID"

###################################