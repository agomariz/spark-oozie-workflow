package com.github.bartekdobija.spark.core;

import org.apache.spark.SparkConf;
import org.apache.spark.SparkContext;
import org.apache.spark.sql.hive.HiveContext;

public class Main {
    public static void main(final String[] args) {
        SparkConf config = new SparkConf();
        SparkContext ctx = new SparkContext(config);
        HiveContext sqlCtx = new HiveContext(ctx);

        sqlCtx.sql("show tables").show();
        sqlCtx.sql("select * from sl_ods.booking limit 10").show();
    }
}
