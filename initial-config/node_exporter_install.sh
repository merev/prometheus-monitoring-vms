#!/bin/bash

echo "* Download Node Exporter fron archive"
wget https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz

echo "* Unarchive the files and remove the archive"
tar xzvf node_exporter-1.6.1.linux-amd64.tar.gz && rm node_exporter-1.6.1.linux-amd64.tar.gz

echo "* Start Node Exportr"
./node_exporter-1.6.1.linux-amd64/node_exporter &> /tmp/node-exporter.log &
