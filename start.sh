#!/bin/bash
chmod 777 ./in
docker-compose up -d --build
#
sleep 10
docker-compose ps