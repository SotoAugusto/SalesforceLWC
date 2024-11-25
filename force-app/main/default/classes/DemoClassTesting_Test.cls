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
private class DemoClassTesting_Test {

    // this method runes before each isTest method, creates temp records and rolls back to the state
    // before running after executing the method
    @TestSetup
    static void makeData(){
        // Case newCase = new Case(Subject = 'Hi there');
        // insert newCase;
        List<Case>  caseList = TestDataFactory.createCases(3);
        insert caseList;
    }

    @isTest
    public static void multiplyNumbersTestPositive(){
        // create records or mocks before start test
        Integer multiplier = 2;
        Test.startTest();
        // instanciate result of method from class i'm testing
        Integer result = new DemoClassTesting().multiplyNumbers(5, multiplier);
        Test.stopTest();
        // System.assertEquals(20, result, 'wrong result');
        // reccomended to use class below
        Assert.areEqual(10, result, 'The returned value was not multiplied correctly');
    }

    @IsTest
    public static void caseUpdaterPositive(){
        // Case newCase = new Case(Subject = 'Hi there');
        // insert newCase;
        // since i have already created record(s) on makeData method
        // i just need to query it(them)
        List<Case> caseList = [SELECT Id, Subject  FROM CASE WHERE Subject = 'Subject 1'];
        Test.startTest();
            DemoClassTesting result = new DemoClassTesting();
            result.caseUpdater(caseList[0]);
        Test.stopTest();
        Assert.areEqual('New case from caseUpdater', caseList[0].Subject, 'Subject not updated');


    }
}