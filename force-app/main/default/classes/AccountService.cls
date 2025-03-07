/**
 * Created by johnconforti on 2/27/23.
 */

public with sharing class AccountService {

    // test all methods that aren't constructors
    public static List<SObject> accounts;
    public static Map<Id, Account> newMap;
    public static Map<Id, Account> oldMap;
    // ! implement this flag, do not insert on test run
    // ? check is running test method
    // ? getFakeId
    @TestVisible
    public static Boolean runTriggerTest = false;

    public AccountService(List<SObject> accountList) {
        accounts = (List<Account>) accountList;
    }

    public AccountService(Map<Id, SObject> accountMap) {
        newMap = (Map<Id, Account>) accountMap;
        accounts = (List<Account>) accountMap.values();
    }

    public AccountService(Map<Id, SObject> accountMap, Map<Id, SObject> oldAccountMap) {
        newMap = (Map<Id, Account>) accountMap;
        oldMap = (Map<Id, Account>) oldAccountMap;
        accounts = (List<Account>) accountMap.values();
    }

    public void createFullName() {
        for(Account account : (List<Account>) accounts) {
            account.Name = Strings.generateRandomString(25);
        }
    }

    public void createRelatedContact(){
        List<Contact> contactList = new List<Contact>();
        for (Account accObj : newMap.values()){
            Contact contactObj = new Contact();
            contactObj.AccountId = accObj.Id;
            contactObj.LastName = accObj.Name + ' sitrar';
            contactList.add(contactObj);
        }
        System.debug('contactList size: ' + contactList.size());
        System.debug('created contacts: ' + contactList);

        if (Contact.SObjectType.getDescribe().isAccessible()
            && Contact.sObjectType.getDescribe().isCreateable()
            && Contact.sObjectType.getDescribe().isUpdateable()
        ) {
            insert contactList;
         }

    }


    public void createTasks(){
        List<Task> taskList = new List<Task>();
        Integer numOfTasks = 3;
        for (Account accObj : newMap.values()) {
            for (Integer taskNum = 1; taskNum <= numOfTasks; taskNum++) {
                Task taskRecord = new Task();
                taskRecord.Subject = 'New Acc ' + accObj.Name + ' Task ' + taskNum + ' sitrar';
                taskRecord.WhatId = accObj.Id;
                taskRecord.Status = 'In Progress';
                taskRecord.Priority = 'Normal';
                taskList.add(taskRecord);
                System.debug('taskRecord for account: ' + taskRecord);
            }
        }
        System.debug('taskList for account size: ' + taskList.size());
        if (Task.SObjectType.getDescribe().isAccessible()
            && Task.sObjectType.getDescribe().isCreateable()
        && !taskList.isEmpty()) {
            insert taskList;
        }
    }
    public void createOpportunity(){
        List<Opportunity> oppList = new List<Opportunity>();
        for (Account accObj : newMap.values()) {
            Opportunity oppObj = new Opportunity();
            oppObj.Name = 'Opportunity for ' + accObj.Name + ' sitrar';
            oppObj.StageName = 'Prospecting';
            oppObj.CloseDate = System.today();
            oppObj.AccountId = accObj.Id;
            oppList.add(oppObj);
        }
        if (!oppList.isEmpty()
            && Opportunity.SObjectType.getDescribe().isAccessible()
            && Opportunity.sObjectType.getDescribe().isCreateable()
            && Opportunity.sObjectType.getDescribe().isUpdateable()
        ) {
            insert oppList;
        }
    }

}