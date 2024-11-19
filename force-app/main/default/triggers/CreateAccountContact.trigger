trigger CreateAccountContact on Account (after insert) {

    // Trigger que cuando se cree un Account se cree un Contact
    // when a Account is created, create a contact and relate the records

    List<Contact> contactList = new List<Contact>();

    for (Account accObj : Trigger.new) {
        Contact contactObj = new Contact();
        contactObj.AccountId = accObj.Id;
        contactObj.LastName = accObj.Name + ' trigger';
        contactList.add(contactObj);
        System.debug('contactObj' + contactObj);
    }

    if (Contact.SObjectType.getDescribe().isAccessible()
        && Contact.sObjectType.getDescribe().isCreateable()
        && Contact.sObjectType.getDescribe().isUpdateable()
        && !contactList.isEmpty()
    ) {
        insert contactList;
    }
}