/**
 * Created by jconforti on 8/2/24.
 */

public with sharing class AccountHandler implements TriggerHandlerInterface {
    public void bulkBefore() {
    }

    public void bulkAfter() {
    }

    public void beforeInsert(List<SObject> newList) {
        AccountService accountService = new AccountService(newList);
        accountService.createFullName();
    }

    public void beforeUpdate(Map<Id, SObject> oldMap, Map<Id, SObject> newMap) {
        AccountService accountService = new AccountService(newMap, oldMap);
        accountService.createFullName();
    }

    public void beforeDelete(Map<Id, SObject> oldMap) {
    }

    public void afterInsert(Map<Id, SObject> newMap) {
    }

    public void afterUpdate(Map<Id, SObject> oldMap, Map<Id, SObject> newMap) {
    }

    public void afterDelete(List<SObject> oldList) {
    }

    public void andFinally() {
    }
}