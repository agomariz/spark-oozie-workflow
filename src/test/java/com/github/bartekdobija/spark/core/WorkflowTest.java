package com.github.bartekdobija.spark.core;

import static org.junit.Assert.assertEquals;

import org.apache.oozie.cli.OozieCLI;
import org.junit.Test;

public class WorkflowTest {

    @Test
    public void testInitialLoadWorkflow(){
        assertEquals(0, new OozieCLI().run(new String[]{
                "validate", "src/main/resources/workflow/workflow.xml" }));
    }


}
