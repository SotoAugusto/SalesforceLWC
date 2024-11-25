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


        @TestSetup
    static void makeData(){
        Account myAccount = new Account(Name = 'Amir');
        insert myAccount;
    }

    @isTest
    static void createRelatedContactTestPositive() {
        List<Account> listAcc = [SELECT Id, Name FROM Account WHERE Name = 'Amir'];
        Map<Id, Account> newMap = new Map<Id, Account>();
        newMap.put(listAcc[0].Id, listAcc[0]);
        AccountService accountService = new AccountService(newMap);
        String accNameContactLastN = listAcc[0].Name + ' sitrar';

        Test.startTest();

        accountService.createRelatedContact();
        Contact newCont = [SELECT LastName FROM Contact WHERE  LastName =: accNameContactLastN LIMIT 1];

        Assert.areEqual(newCont.LastName, accNameContactLastN, 'Contact name doesnt match');
        Test.stopTest();
    }

    @IsTest
    static void createTasksPOSITIVE(){

        Test.startTest();

        Assert.
        // query what id = account, is true?
        // is empty assert?
        // is not null

        assert
        Test.stopTest();

    }


}