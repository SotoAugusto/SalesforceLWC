trigger CreateOpportunityTask on Opportunity (after insert) {


    List<Task> taskList = new List<Task>();

    for (Opportunity oppObj : Trigger.new) {
            Task taskRecord = new Task();
            taskRecord.Subject = 'New Opp Task from trigger for ' + oppObj.Name;
            taskRecord.WhatId = oppObj.Id;
            taskRecord.Status = 'In Progress';
            taskRecord.Priority = 'Normal';
            System.debug('taskRecord: ' + taskRecord);
            taskList.add(taskRecord);
    }
System.debug('taskList: ' + taskList);
    if (!taskList.isEmpty()
        && Opportunity.SObjectType.getDescribe().isAccessible()
        && Opportunity.sObjectType.getDescribe().isCreateable()
        && Opportunity.sObjectType.getDescribe().isUpdateable()
        ) {
            insert taskList;
    }

}