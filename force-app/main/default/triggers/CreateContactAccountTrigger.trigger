trigger CreateContactAccountTrigger on Contact (after insert) {
// https://salesforce.stackexchange.com/questions/27241/write-a-trigger-that-automatically-create-a-contact-when-account-is-created

// Trigger que cuando cree un Contact, creeara una Account utilizando
// el mismo nombre del Contact, relacionar ambos records.

// doesn't cover update cases
// When creating a Contact, create a Account with the same name
// !TODO include update use case
        // create list for Account records
        // All triggers are bulk triggers by default, and can process multiple records at a time. You should always plan on processing more than one record at a time.
        List<Account> accountsList = new List<Account>();

        System.debug('Trigger.new: ' + Trigger.new);
        // run this for each record that triggered this (Trigger.new)
        for (Contact cont : Trigger.new) {
            System.debug('Trigger.new inside for: ' + Trigger.new);
            System.debug('cont: ' + cont);
            Account acc = new Account();
            acc.Name = cont.FirstName + ' ' + cont.LastName;
            System.debug('Account: ' + acc);
            accountsList.add(acc);
        }
        System.debug('accountsList: ' + accountsList);

    if (Account.SObjectType.getDescribe().isAccessible() && Account.sObjectType.getDescribe().isCreateable()) {
        insert accountsList;
    } else{
        // cont.addErro
    }

}