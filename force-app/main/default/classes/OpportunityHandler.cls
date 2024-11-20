public with sharing class OpportunityHandler implements TriggerHandlerInterface {
    public void bulkBefore() {
    }

    public void bulkAfter() {
    }

    public void beforeInsert(List<SObject> newList) {
    }

    public void beforeUpdate(Map<Id, SObject> oldMap, Map<Id, SObject> newMap) {
    }

    public void beforeDelete(Map<Id, SObject> oldMap) {
    }

    public void afterInsert(Map<Id, SObject> newMap) {
        OpportunityService opportunityService = new OpportunityService(newMap);
        opportunityService.createTasks();

    }

    public void afterUpdate(Map<Id, SObject> oldMap, Map<Id, SObject> newMap) {
    }

    public void afterDelete(List<SObject> oldList) {
    }

    public void andFinally() {
    }
}