public with sharing class OpportunityService {

    public static List<SObject> opportunities;
    public static Map<Id, Opportunity> newMap;
    public static Map<Id, Opportunity> oldMap;

    public OpportunityService(List<SObject> opportunityList) {
        opportunities = (List<Opportunity>) opportunityList;
    }

    public OpportunityService(Map<Id, SObject> opportunityMap) {
        newMap = (Map<Id, Opportunity>) opportunityMap;
        opportunities = (List<Opportunity>) opportunityMap.values();
    }

    public OpportunityService(Map<Id, SObject> opportunityMap, Map<Id, SObject> oldOpportunityMap) {
        newMap = (Map<Id, Opportunity>) opportunityMap;
        oldMap = (Map<Id, Opportunity>) oldOpportunityMap;
        opportunities = (List<Opportunity>) opportunityMap.values();
    }

    public void createTasks() {
        List<Task> taskList = new List<Task>();

        System.debug(newMap.values().size());
        for (Opportunity oppObj : newMap.values()) {
            Task taskRecord = new Task();
            taskRecord.Subject = 'New Opp Task from sitrar for ' + oppObj.Name;
            taskRecord.WhatId = oppObj.Id;
            taskRecord.Status = 'In Progress';
            taskRecord.Priority = 'Normal';
            taskList.add(taskRecord);
        }
        if (!taskList.isEmpty()
            && Opportunity.SObjectType.getDescribe().isAccessible()
            && Opportunity.sObjectType.getDescribe().isCreateable()
            && Opportunity.sObjectType.getDescribe().isUpdateable()
        ) {
            insert taskList;
        }
    }
}