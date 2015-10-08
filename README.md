Spark submit example:

spark-submit -v --master yarn --deploy-mode cluster --files hdfs:///jobs/project/hive-site.xml --jars /opt/spark/lib/datanucleus-api-jdo-3.2.6.jar,/opt/spark/lib/datanucleus-core-3.2.10.jar,/opt/spark/lib/datanucleus-rdbms-3.2.9.jar --class com.company.bi.project.core.Predict hdfs:///jobs/project/lib/project-1.0.0.jar

Spark Action in Oozie shows NullPointerException because of this: 

https://issues.apache.org/jira/browse/SPARK-7706
