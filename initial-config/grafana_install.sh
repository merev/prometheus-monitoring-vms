#!/bin/bash

echo "* Install required packages and download the Grafana repository signing key"
apt-get install -y apt-transport-https curl jq
apt-get install -y software-properties-common wget
wget -q -O /usr/share/keyrings/grafana.key https://apt.grafana.com/gpg.key

echo "* Add a repository for stable releases"
echo "deb [signed-by=/usr/share/keyrings/grafana.key] https://apt.grafana.com stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list

echo "* Install Grafana"
apt-get update
apt-get install -y grafana

echo "* Start and enable the service"
systemctl daemon-reload
systemctl enable --now grafana-server
