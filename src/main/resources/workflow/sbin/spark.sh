#!/usr/bin/env bash

# WARNING:
# It is CRITICAL to run spark-submit in a sanitised environment where classpath has not been affected by the Oozie action.
# The hack for this is to call spark-submit using a wrapper env -i spark-submit ...

jar=$1
class=$2
keytab=$3
principal=$4

tmp_location=/tmp/$$-$(date +%y%m%d%H%M%S).jar

kinit -kt ${keytab} ${principal} \
&& hdfs dfs -copyToLocal ${jar} ${tmp_location} \
&& env -i /opt/spark/bin/spark-submit \
  -v \
  --master yarn \
  --deploy-mode cluster \
  --files /opt/spark/conf/hive-site.xml \
  --jars /opt/spark/lib/datanucleus-api-jdo-3.2.6.jar,/opt/spark/lib/datanucleus-core-3.2.10.jar,/opt/spark/lib/datanucleus-rdbms-3.2.9.jar,/opt/cloudera/parcels/CDH-5.4.2-1.cdh5.4.2.p0.2/lib/hadoop-yarn/lib/spark-1.3.0-cdh5.4.2-yarn-shuffle.jar \
  --class ${class} ${tmp_location} \
&& rm -f ${tmp_location}