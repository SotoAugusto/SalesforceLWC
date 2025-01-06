public with sharing class ContactService {

    public static List<SObject> contacts;
    public static Map<Id, Contact> newMap;
    public static Map<Id, Contact> oldMap;

    public ContactService(List<SObject> contactList) {
        contacts = (List<Contact>) contactList;
    }

    public ContactService(Map<Id, SObject> contactMap) {
        newMap = (Map<Id, Contact>) contactMap;
        contacts = (List<Contact>) contactMap.values();
    }

    public ContactService(Map<Id, SObject> contactMap, Map<Id, SObject> oldContactMap) {
        newMap = (Map<Id, Contact>) contactMap;
        oldMap = (Map<Id, Contact>) oldContactMap;
        contacts = (List<Contact>) contactMap.values();
    }

    public void createTasks() {
        List<Task> taskList = new List<Task>();
        Integer numTasks = 3;
        for (Contact contObj : newMap.values()) {
            for (Integer tasknum = 1; tasknum <= numTasks; tasknum++) {
                Task taskRecord = new Task();
                taskRecord.Subject = 'New Contact ' + contObj.LastName + ' Task ' + tasknum + ' sitrar';
                // !problems
                taskRecord.WhoId = contObj.Id;
                taskRecord.Status = 'In Progress';
                taskRecord.Priority = 'Normal';
                taskList.add(taskRecord);
                System.debug('taskRecord for contact: ' + taskRecord);
            }
        }
        System.debug('taskList for contact size: ' + taskList.size());
        if (Task.SObjectType.getDescribe().isAccessible()
            && Task.sObjectType.getDescribe().isCreateable()
        && !taskList.isEmpty()) {
            insert taskList;
        }
    }
}