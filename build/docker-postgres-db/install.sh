#!/bin/bash

# https://github.com/glaubercini/docker-adventureworks-for-postgres
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE "Adventureworks";
EOSQL

cd /data
psql -d Adventureworks --username "$POSTGRES_USER" < /data/install.sql