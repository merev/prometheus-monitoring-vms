#!/bin/bash

echo "* Grafana URL and admin credentials set"
GRAFANA_URL="http://localhost:3000"
ADMIN_USERNAME="admin"
ADMIN_PASSWORD="admin"

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
echo " Log in and get session cookie"
SESSION_COOKIE=$(curl -c cookies.txt -s -X POST \
  -H "Content-Type: application/json" \
  -d "{\"user\":\"$ADMIN_USERNAME\",\"email\":\"\",\"password\":\"$ADMIN_PASSWORD\"}" \
  "$GRAFANA_URL/login" | grep -oP '(?<=Set-Cookie: grafana_sess=)[^;]+')

echo " Add Prometheus data source using Grafana API with session cookie"
curl -b cookies.txt -s -X POST \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD" \
  "$GRAFANA_URL/api/datasources"

echo "* Clean up cookies file"
rm cookies.txt