@isTest
private class ContactServiceTest {

        @TestSetup
    static void makeData(){
        // accList = TestDataFactory.createAccounts(10);
        List<Contact> contactList = TestDataFactory.createContacts(10);
        insert contactList;
    }
@isTest
    static void createTasksPOSITIVE() {

        Map<Id, Contact> newMapContact = new Map<Id, Contact>([SELECT Id, LastName FROM Contact WHERE LastName LIKE '%test%']);

        System.debug('test newMapContact size :' + newMapContact.size());
        System.debug('test newMapContact :' + newMapContact);

        Test.startTest();
        ContactService contactService = new ContactService(newMapContact);
        contactService.createTasks();
        List<Task> taskList = new List<Task>([SELECT Id, WhatId,  Subject, Status, Priority FROM Task WHERE Subject LIKE '%test LastName %']);

        Test.stopTest();

        // 10 accounts, 3 per account = 30
        // 10 accounts on insert + 10 account on instantiation = 20
        // TOTAL 60
        System.assertEquals(60, taskList.size(), 'incorrect number of task per contact');

        Id lastContactId = [SELECT Id FROM Contact ORDER BY CreatedDate DESC LIMIT 1].Id;
        Id lastTaskWhoId = [SELECT Id, WhoId FROM Task ORDER BY CreatedDate DESC LIMIT 1].WhoId;

        System.Assert.areEqual(lastContactId, lastTaskWhoId, 'Task was not assigned to the correct Contact');


    }
}