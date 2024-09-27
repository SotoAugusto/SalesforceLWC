public with sharing class JestDemoController {
   @AuraEnabled(Cacheable=true)
    public static List<Account> getAccounts(){
        try{
            return [SELECT Id, Name FROM Account LIMIT 5];
        }catch (Exception e){
            throw new AuraHandledException(e.getMessage());
        }
    }
}