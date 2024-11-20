public interface TriggerHandlerInterface {
    void bulkBefore();
    void bulkAfter();
    void beforeInsert(List<SObject> newList);
    void beforeUpdate(Map<Id, SObject> oldMap, Map<Id, SObject> newMap);
    void beforeDelete(Map<Id, SObject> oldMap);
    void afterInsert(Map<Id, SObject> newMap);
    void afterUpdate(Map<Id, SObject> oldMap, Map<Id, SObject> newMap);
    void afterDelete(List<SObject> oldList);
    void andFinally();
}