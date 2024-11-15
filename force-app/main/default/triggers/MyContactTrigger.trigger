trigger MyContactTrigger on Contact (before update, after update) {
    // triggers aren't apex classes
    // should use trigger handler
    // after triggers CAN NOT modify data, it's read only

    if (Trigger.isBefore && Trigger.isInsert) {
        System.debug('Trigger fired on is before and is insert');
    }
// try isAfter
    if (Trigger.isBefore && Trigger.isUpdate) {
        System.debug('Trigger fired on is before and is update');
        triggerMethod();
    }

    if (Trigger.isAfter && Trigger.isUpdate) {
        System.debug('Trigger fired on is after and is update');

    }

    // you can make methods here, but shouldn't
    public static void triggerMethod() {
        // run this for each new record
        for(Contact cont : Trigger.new) {
            // get the old records
            Contact oldContact = Trigger.oldMap.get(cont.Id);
            System.debug('Old contact: ' + oldContact);
            // if LastName changed
            if (oldContact.LastName != cont.LastName) {
                System.debug('LastName changed');
                // cont.FirstName = 'newCustomNamessss';
            }
            System.debug('This is the contact updated: ' + cont);
        }


    }
}