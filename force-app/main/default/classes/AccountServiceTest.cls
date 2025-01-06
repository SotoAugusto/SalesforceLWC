/**
* This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 *
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class AccountServiceTest {

    // List<Account> accList = new List<Account>();

    // ! implemten false or failed test
    //!  try fake ids, or ids from other objects
    @TestSetup
    static void makeData(){
        // accList = TestDataFactory.createAccounts(10);
        List<Account> accList = TestDataFactory.createAccounts(10);
        insert accList;
    }

    @isTest
    static void createRelatedContactTestPositive() {
        // this.accList = accList;
        // insert this.accList;
        Map<Id,Account> newMapAcc = new Map<Id,Account>([SELECT Id, Name FROM Account]);
        System.debug('test newMappAcc size :' + newMapAcc.size());
        System.debug('test newMappAcc :' + newMapAcc);

        Test.startTest();
            AccountService accountService = new AccountService(newMapAcc);
            accountService.createRelatedContact();
            List<Contact> contactList = new List<Contact>([SELECT Id, LastName FROM Contact]);
        Test.stopTest();

        System.debug('test contactList size: ' + contactList.size());
        System.debug('test contactList: ' + contactList);
        for (Integer i = 0; i < contactList.size(); i++) {
        System.debug('test contactList item : [' + i + '] : ' + contactList[i]);
        }

        Assert.isNotNull(contactList[contactList.size() - 1].Id, 'Id is null');

        Assert.isInstanceOfType(accountService, AccountService.class, 'Not expected type');

        // should be 20 accounts, as in makedata we insert 10 accounts,
        //  and in this test we query and instanciate 10 more
        Assert.areEqual(20, contactList.size(), 'Contact records not created');

        // check lastname matches on account and contact
        String contactLastN = contactList[contactList.size() - 1].LastName;
        System.debug('test contactLastN: ' + contactLastN);
        String accountLastN = [SELECT Name FROM Account ORDER BY CreatedDate DESC LIMIT 1].Name + ' sitrar';
        System.debug('test accountLastN: ' + accountLastN);
        Assert.areEqual(accountLastN , contactLastN, 'Contact name doesnt match');


    }

        @IsTest
        static void createTasksPOSITIVE(){
        // query created accounts on makedata
            Map<Id,Account> newMapAcc = new Map<Id,Account>([SELECT Id, Name FROM Account]);
            System.debug('test newMappAcc size :' + newMapAcc.size());
            System.debug('test newMappAcc :' + newMapAcc);
            Test.startTest();
                AccountService accountService = new AccountService(newMapAcc);
                // filter by subject containing name
                accountService.createTasks();
                List<Task> taskList = new List<Task>([SELECT Id, WhatId,  Subject, Status, Priority FROM Task WHERE Subject LIKE '%test Username %']);
            Test.stopTest();


        System.debug('test taskList size: ' + taskList.size());
        System.debug('test taskList: ' + taskList);
        for (Integer i = 0; i < taskList.size(); i++) {
        System.debug('test taskList item : [' + i + '] : ' + taskList[i]);
        }

        Assert.isNotNull(taskList[taskList.size() - 1].Id, 'Id is null');

        Assert.isInstanceOfType(accountService, AccountService.class, 'Not expected type');

        // if !filterbyname
        //inserting 10 accounts creates 10 contacts, and 10 opp
        // 3 task per acc, 3 task per cont, 1 per opp
        //30, 30, 10 = 70
        // instantiation of account service + 10 accounts in test
        //30 more task
        // 70 + 30 = 100 task in total

        // if filterbyname: 30 insert + 30 instatiation
        Assert.areEqual(100, taskList.size(), 'task records not created correctly');


        // check name matches on account and task
        String accName = [SELECT Name FROM Account ORDER BY CreatedDate DESC LIMIT 1].Name;
        Boolean isTaskSubjCorrect = taskList[taskList.size() - 1].Subject.contains('New Acc ' + accName);

        Assert.isTrue(isTaskSubjCorrect, 'task subject not created correctly');


        Id lastAccId = [SELECT Id FROM Account ORDER BY CreatedDate DESC LIMIT 1].Id;
        Id lastTaskWhatId = [SELECT Id, WhatId FROM Task ORDER BY CreatedDate DESC LIMIT 1].WhatId;

        Assert.areEqual(lastAccId, lastTaskWhatId, 'Incorrect relationship con task and account');

        }


}