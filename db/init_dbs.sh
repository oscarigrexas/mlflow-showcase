#!/bin/bash
# set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE prefect;
    CREATE DATABASE mlflow;

    \c prefect
    CREATE USER $POSTGRES_PREFECT_USER WITH PASSWORD '$POSTGRES_PREFECT_PASSWORD';
    GRANT ALL PRIVILEGES ON DATABASE prefect TO $POSTGRES_PREFECT_USER;
    GRANT ALL ON SCHEMA public TO $POSTGRES_PREFECT_USER;

    \c mlflow
    CREATE USER $POSTGRES_MLFLOW_USER WITH PASSWORD '$POSTGRES_MLFLOW_PASSWORD';
    GRANT ALL PRIVILEGES ON DATABASE mlflow TO $POSTGRES_MLFLOW_USER;
    GRANT ALL ON SCHEMA public TO $POSTGRES_MLFLOW_USER;
EOSQL