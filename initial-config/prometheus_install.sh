#!/bin/bash

echo "* Download Prometheus fron archive"
wget https://github.com/prometheus/prometheus/releases/download/v2.46.0/prometheus-2.46.0.linux-amd64.tar.gz

echo "* Unarchive the files and remove the archive"
tar xzvf prometheus-2.46.0.linux-amd64.tar.gz && rm prometheus-2.46.0.linux-amd64.tar.gz

echo "* Remove the default configuration and import the custom files"
rm ./prometheus-2.46.0.linux-amd64/prometheus.yml
cp /shared/prometheus_files/prometheus.yaml ./prometheus-2.46.0.linux-amd64/
cp /shared/prometheus_files/applications.json ./prometheus-2.46.0.linux-amd64/

echo "* Start Prometheus"
./prometheus-2.46.0.linux-amd64/prometheus --config.file prometheus.yaml --web.enable-lifecycle 2>> /tmp/prometheus.log &
