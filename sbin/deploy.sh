#!/usr/bin/env bash

# Before running this script make sure that a Kerberos ticket for the correct
# user exists. In this case hadoop_oozie is required.

OOZIE_INSTANCE=$1
PROJECT_NAME=spark-oozie-workflow-1.0.0
HDFS_COORD_LOCATION=/jobs/spark-oozie-workflow/
KEYTABFILE=$2
PRINCIPAL=$3

function deploy {
    echo "Building process.." \
    && mvn clean package -DskipTests \
    && echo "Deploying to the cluster..." \
    && tar zxf target/$PROJECT_NAME.tar.gz -C target/ \
    && hdfs dfs -put -f target/$PROJECT_NAME/* $HDFS_COORD_LOCATION \
    && hdfs dfs -chown -R hadoop_oozie:hadoop $HDFS_COORD_LOCATION \
    && echo "Starting coordinator..." \
    && oozie job \
        -oozie http://$OOZIE_INSTANCE:11000/oozie/ \
        -config target/$PROJECT_NAME/config.xml \
        -Duser.name=hadoop_oozie \
        -DkeytabLocation=${KEYTABFILE} \
        -Dprincipal=${PRINCIPAL} \
        -Dmaster=${OOZIE_INSTANCE} \
        -submit
}

function main {
    deploy
}

main

