/**
 * Created by ausoto on 2024-08-18.
 */

public class AccountController {
//    @AuraEnabled enables Lightning components to access Apex methods and properties.
//    To improve runtime performance, set @AuraEnabled(cacheable=true) to cache the method results on the client.
//    To set cacheable=true, a method must only get data. It can’t mutate data.
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(String extraFields) {

//        add where

//        List<String> accFieldsList = new List<String>();
        String selectStr = 'Id, Name, Industry, AnnualRevenue' + extraFields;
        String query = 'SELECT '+ selectStr + ' FROM Account';
        return Database.query(query);
//        return [
//            SELECT Id, Name, Industry, AnnualRevenue
//            FROM Account
//
//        ];
    }
}
