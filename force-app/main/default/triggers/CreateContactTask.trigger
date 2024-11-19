trigger CreateContactTask on Contact (after insert) {
// Trigger que cree 3 diferentes task al momento de que se cree un Contact, relacionarlos

    List<Task> taskList = new List<Task>();

    // run this for each record that triggered this (Trigger.new)
    for (Contact contObj : Trigger.new) {
        System.debug('contObj: ' + contObj);
        for (Integer tasknum = 1; tasknum <= 3; tasknum++) {
            Task taskRecord = new Task();
            taskRecord.Subject = 'New Contact Task ' + tasknum;
            // !problems
            taskRecord.WhoId = contObj.Id;
            taskRecord.Status = 'In Progress';
            taskRecord.Priority = 'Normal';
            System.debug('taskRecord: ' + taskRecord);
            taskList.add(taskRecord);
        }
    }

     System.debug('taskList: ' + taskList);
    // checar si la lista tiene items
    if (Task.SObjectType.getDescribe().isAccessible()
    && Task.sObjectType.getDescribe().isCreateable()
    && !taskList.isEmpty()) {
        insert taskList;
    }

}