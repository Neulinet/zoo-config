#!/bin/bash

wget http://demos.pihomeserver.fr/influxdb_0.8.6_armhf.deb

dpkg -i influxdb*.deb

service influxdb start
sleep 3

influx_admin_param="u=root&p=root"

user="openhab"
password=$user
db_name=$user

# TODO Change /opt/influxdb/shared/config.toml to only listen to localhost

echo "Create database '${db_name}'"
curl -X POST 'http://localhost:8086/db?${influx_admin_param}' \
  -d '{"name": "${db_name}"}'

echo "Create user '${user}' for db '${db_name}'"
curl -X POST 'http://localhost:8086/db/${db_name}/users?${influx_admin_param}' \
  -d '{"name": "${user}", "password": "${password}"}'

#echo "Set privileges of '${user}' to db 'openhab'"
#curl -X POST 'http://localhost:8086/db/${db_name}/users/${user}?${influx_admin_param}' \
#  -d '{"readFrom": "${db_name}", "writeTo": "${db_name}"}'
