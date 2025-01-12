// https://insulet-6b-dev-ed.
// curl -H "Authorization: Bearer sessionId" "https://insulet-6b-dev-ed.com/services/apexrest/Account/accountId"

@RestResource(urlMapping='/Account/*')
global with sharing class MyRestResource {

    @HttpDelete
    global static String doDelete() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        Account account = [SELECT Id FROM Account WHERE Id = :accountId];
        delete account;
        return 'deleted';
    }

    @HttpGet
    global static List<Account> doGet() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;
        // String accountId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        // Account result = [SELECT Id, Name, Phone, Website FROM Account LIMIT 1];
        return [SELECT Id, Name, Phone, Website FROM Account LIMIT 10];
    }

    @HttpPost
    global static String doPost(String name,
    String phone, String website) {
        Account account = new Account();
        account.Name = name;
        account.phone = phone;
        account.website = website;
        insert account;
        return account.Id;
    }
}