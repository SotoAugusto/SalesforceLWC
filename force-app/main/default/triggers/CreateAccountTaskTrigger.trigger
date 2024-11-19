trigger CreateAccountTaskTrigger on Account (after insert) {
// https://trailhead.salesforce.com/trailblazer-community/feed/0D54V00007T4WH0SAN

// Trigger que cree 3 diferentes task al momento de que se cree una Account (CreateAccountTaskTrigger)

    // create list for Account records
    // on account creation, create 3 tasks for each account

    List<Task> taskList = new List<Task>();

    System.debug('Trigger.new: ' + Trigger.new);
    // run this for each record that triggered this (Trigger.new)
    for (Account acc : Trigger.new) {
        System.debug('acc: ' + acc);
        for (Integer tasknum = 1; tasknum <= 3; tasknum++) {
            Task taskRecord = new Task();
            taskRecord.Subject = 'New Account Task ' + tasknum;
            taskRecord.WhatId = acc.Id;
            taskRecord.Status = 'In Progress';
            taskRecord.Priority = 'Normal';
            System.debug('taskRecord: ' + taskRecord);
            taskList.add(taskRecord);
        }
    }
    // https://salesforce.stackexchange.com/questions/233319/apex-pmd-problem-validate-crud-permission-before-soql-dml-operation
    System.debug('taskList: ' + taskList);
    // checar si la lista tiene items
    if (Task.SObjectType.getDescribe().isAccessible()
    && Task.sObjectType.getDescribe().isCreateable()
    && !taskList.isEmpty()) {
        insert taskList;
    }

    // System.debug('accountsList: ' + accountsList);
    // insert accountsList;

}