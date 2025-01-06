// class to generate mock data for testing, ment to be reusable in different testclasses
public with sharing class TestDataFactory {

    public static List<Case> createCases(Integer numCases) {
        List<Case> caseList = new List<Case>();
        for (Integer i = 1; i <= numCases; i++) {
            Case newCase = new Case(Subject = 'test Subject ' + i);
            caseList.add(newCase);
        }
        return caseList;
    }

    public static List<Account> createAccounts(Integer numAccs){
        List<Account> accList = new List<Account>();

        for (Integer i = 1; i <= numAccs; i++) {
            Account newAcc = new Account(Name = 'test Username ' + i);
            accList.add(newAcc);
        }
        return accList;
    }

        public static List<Contact> createContacts(Integer numContacts){
        List<Contact> contactList = new List<Contact>();

        for (Integer i = 1; i <= numContacts; i++) {
            Contact newContact = new Contact(LastName = 'test LastName ' + i);
            contactList.add(newContact);
        }
        return contactList;
    }

        public static List<Opportunity> createOpportunities(Integer numOpportunities){
        List<Opportunity> opportuniyList = new List<Opportunity>();

        for (Integer i = 1; i <= numOpportunities; i++) {
            Opportunity newOpportunity = new Opportunity(Name = 'test Opportunity' + i, StageName = 'Prospecting', CloseDate = System.today());

            opportuniyList.add(newOpportunity);
        }
        return opportuniyList;
    }
}