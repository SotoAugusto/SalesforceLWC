// this supposed to be a normal apex class with logic which we need to test
public with sharing class DemoClassTesting {
    public Integer multiplyNumbers(Integer intOne, Integer intTwo){
        return intOne * intTwo;
    }

    public void caseUpdater(Case caseToUpdate) {
        caseToUpdate.subject = 'New case from caseUpdater';
        update caseToUpdate;

    }
}