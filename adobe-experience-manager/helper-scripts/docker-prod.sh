#!/bin/bash


set -o errexit
set -o xtrace
set -o nounset

echo "Creating network if doesn't exist"
docker network create prod-network && rc=$? || rc=$?
echo "create code: $rc"

echo "Stopping & removing running containers"
docker stop myapp.dispatcher && docker rm myapp.dispatcher && rc=$? || rc=$?
echo "stop code myapp.dispatcher: $rc"
docker stop myapp.publisher2 && docker rm myapp.publisher2 && rc=$? || rc=$?
echo "stop code myapp.publisher2: $rc"
docker stop myapp.publisher1 && docker rm myapp.publisher1 && rc=$? || rc=$?
echo "stop code myapp.publisher1: $rc"
docker stop myapp.author && docker rm myapp.author && rc=$? || rc=$?
echo "stop code myapp.author: $rc"

echo "Launching containers ...."
docker run -t -d --name myapp.dispatcher -p 80:80 -p 8081:8080 -h myapp.dispatcher --net=prod-network aem-dispatcher
docker run -t -d --name myapp.publisher2 -p 4212:4503 --net=prod-network aem-pub
docker run -t -d --name myapp.publisher1 -p 4211:4503 --net=prod-network aem-pub
docker run -t -d --name myapp.author -p 4201:4502 --net=prod-network aem-auth
