    @isTest
    private class OpportunityServiceTest {

        @TestSetup
        static void makeData(){
            List<Opportunity> oppList = TestDataFactory.createOpportunities(10);
            insert oppList;
        }
        @isTest
        private static void createTasksTestPOSITIVE() {

            Map<Id, Opportunity> newMapOpportunity = new Map<Id, Opportunity>([SELECT Id, Name FROM Opportunity WHERE Name LIKE '%test%']);

            System.debug('test newMapOpportunity size :' + newMapOpportunity.size());
            System.debug('test newMapOpportunity :' + newMapOpportunity);

            Test.startTest();
                OpportunityService opportunityService = new OpportunityService(newMapOpportunity);
                opportunityService.createTasks();
                List<Task> taskList = new List<Task>([SELECT Id, WhatId,  Subject, Status, Priority FROM Task WHERE Subject LIKE '%New Opp Task%']);

            Test.stopTest();

            // 10 opps, 1 per account = 10
            // 10 opps on insert + 10 opps on instantiation = 20
            // TOTAL 20
            System.assertEquals(20, taskList.size(), 'incorrect number of task per opp');

            Id lastOppId = [SELECT Id FROM Opportunity ORDER BY CreatedDate ASC LIMIT 1].Id;
            System.debug('[30] [OpportunityServiceTest] lastOppId: ' + lastOppId);
            Id lastTaskWhatId = [SELECT Id, WhatId FROM Task ORDER BY CreatedDate DESC LIMIT 1].WhatId;
            System.debug('[32] [OpportunityServiceTest] lastTaskWhatId: ' + lastTaskWhatId);

            System.Assert.areEqual(lastOppId, lastTaskWhatId, 'Task was not assigned to the correct Contact');


        }



        // new?
        // Opportunity opp = [SELECT Id, Name FROM Opportunity WHERE Name = 'Test Opp' LIMIT 1];
        // System.debug('opp in testOpp: ' + opp);
        // Test.startTest();
        // OpportunityService service = new OpportunityService();
        // service.createTasks();
        // Test.stopTest();

        // List<Task> taskList = [SELECT Id, Subject FROM Task WHERE WhatId =: opp.Id];
        // System.debug('taskList in testOpp: ' + taskList.size());
        // System.assertNotEquals(2, taskList.size(), 'Error in OpportunityService class');
    // }
}