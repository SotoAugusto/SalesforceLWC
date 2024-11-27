/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 *
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class AccountServiceTest {

    // List<Account> accList = new List<Account>();

    @TestSetup
    static void makeData(){
        // accList = TestDataFactory.createAccounts(10);
        List<Account> accList = TestDataFactory.createAccounts(10);
        insert accList;
    }

    @isTest
    static void createRelatedContactTestPositive() {
        // this.accList = accList;
        // insert this.accList;
        Map<Id,Account> newMapAcc = new Map<Id,Account>([SELECT Id, Name FROM Account]);
        Test.startTest();
        AccountService accountService = new AccountService(newMapAcc);
        accountService.createRelatedContact();
        List<Contact> contactList = new List<Contact>([SELECT Id, LastName FROM Contact]);

        Test.stopTest();

        Assert.isInstanceOfType(accountService, AccountService.class, 'Not expected type');

        // should be 20 accounts, as in makedata we insert 10 accounts,
        //  and in this test we query and create 10 more
        Assert.areEqual(20, contactList.size(), 'Contact records not created');

        // check lastname matches on account and contact
        String contactLastN = contactList[contactList.size() - 1].LastName;
        System.debug('contactLastN: ' + contactLastN);
        String accountLastN = [SELECT Name FROM Account ORDER BY CreatedDate DESC LIMIT 1].Name + ' sitrar';
        System.debug('accountLastN: ' + accountLastN);
        Assert.areEqual(accountLastN , contactLastN, 'Contact name doesnt match');

// String accNameContactLastN = listAcc[i].Name + ' sitrar';

//         List<Account> listAcc = [SELECT Id, Name FROM Account];
//         System.debug(listAcc);
//         Map<Id, Account> newMap = new Map<Id, Account>();
//         for (Integer i = 0; i < listAcc.size(); i++) {
//             newMap.put(listAcc[i].Id, listAcc[i]);
//             String accNameContactLastN = listAcc[i].Name + ' sitrar';
//         }
//          Test.startTest();
//             AccountService accountService = new AccountService(newMap);
//             accountService.createRelatedContact();
//             Contact newCont = [SELECT LastName FROM Contact WHERE  LastName =: accNameContactLastN LIMIT 1];
//             Test.stopTest();
//             Assert.areEqual(newCont.LastName, accNameContactLastN, 'Contact name doesnt match');
    }

    // @IsTest
    // static void createTasksPOSITIVE(){

        // Test.startTest();

        // Assert.areEqual(expected, actual, message);
        // Assert.areNotEqual(expected, actual, message);
        // Assert.fail(message);
        // Assert.isFalse(condition, message);
        // Assert.isInstanceOfType(ObjectInstance, SystemType, message);
        // Assert.isNull(variable, message);
        // Assert.isNotNull(variable, message);

        // query what id = account, is true?
        // is empty assert?
        // is not null

        // Test.stopTest();

    // }


}