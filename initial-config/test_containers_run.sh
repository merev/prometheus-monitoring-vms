#!/bin/bash

echo "* Run test docker containers"
docker container run -d --name worker1 -p 8081:8080 shekeriev/goprom
docker container run -d --name worker2 -p 8082:8080 shekeriev/goprom