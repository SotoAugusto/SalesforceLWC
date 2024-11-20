/**
 * Created by johnconforti on 2/27/23.
 */

public with sharing class AccountService {

    public static List<SObject> accounts;
    public static Map<Id, Account> newMap;
    public static Map<Id, Account> oldMap;

    public AccountService(List<SObject> accountList) {
        accounts = (List<Account>) accountList;
    }

    public AccountService(Map<Id, SObject> accountMap) {
        newMap = (Map<Id, Account>) accountMap;
        accounts = (List<Account>) accountMap.values();
    }

    public AccountService(Map<Id, SObject> accountMap, Map<Id, SObject> oldAccountMap) {
        newMap = (Map<Id, Account>) accountMap;
        oldMap = (Map<Id, Account>) oldAccountMap;
        accounts = (List<Account>) accountMap.values();
    }

    public void createFullName() {
        for(Account account : (List<Account>) accounts) {
            account.Name = Strings.generateRandomString(25);
        }
    }

    public void createRelatedContact(){
        for (Account accObj : newMap.values()) {
            Contact contactObj = new Contact();
            contactObj.AccountId = accObj.Id;
            contactObj.LastName = accObj.Name + ' sitrar';
            // contactList.add(contactObj);
            System.debug('contactObj' + contactObj);
            if (Contact.SObjectType.getDescribe().isAccessible()
                && Contact.sObjectType.getDescribe().isCreateable()
                && Contact.sObjectType.getDescribe().isUpdateable()
            ) {
                insert contactObj;
            }
        }
    }

}