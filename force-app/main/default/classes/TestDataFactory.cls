// class to generate mock data for testing, ment to be reusable in different testclasses
public with sharing class TestDataFactory {

    public static List<Case> createCases(Integer numCases) {
        List<Case> caseList = new List<Case>();
        for (Integer i = 0; i < numCases; i++) {
            Case newCase = new Case(Subject = 'Subject ' + i);
            caseList.add(newCase);
        }
        return caseList;
    }
}