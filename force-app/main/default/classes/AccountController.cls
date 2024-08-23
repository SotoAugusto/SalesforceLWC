/**
 * Created by ausoto on 2024-08-18.
 */

public class AccountController {
//    @AuraEnabled enables Lightning components to access Apex methods and properties.
//    To improve runtime performance, set @AuraEnabled(cacheable=true) to cache the method results on the client.
//    To set cacheable=true, a method must only get data. It can’t mutate data.
    @AuraEnabled(cacheable=false)
    public static List<Account> getAccounts(List<String> fields, Map<String, String> whereClauses) {
        // combine default fields with the fields the user added
        List<String> defaultFields = new List<String>{'Id', 'Name', 'Industry','AnnualRevenue'};
        defaultFields.addAll(fields);

        // add commas between values of all fields
        String fieldList = String.join(new List<String>(defaultFields), ', ');

        // construct the where clause, adds \ to support ' on input
        // soql editor doesnt support \
        List<String> conditions = new List<String>();
        for (String key : whereClauses.keySet()) {
            conditions.add(key + ' = \'' + whereClauses.get(key) + '\'');
//            conditions.add(key + ' = ' + whereClauses.get(key)); // without \
        }
        String whereClause = String.join(conditions, ' AND ');

        // construct the final query, Sobject account is hardcoded, could be a variable
        String query = 'SELECT ' + fieldList + ' FROM Account';
        if (!whereClauses.isEmpty()) {
            query += ' WHERE ' + whereClause;
        }

        // execute the query and return the results
        System.debug(Database.query(query));
        return Database.query(query);
    }//end function
}//end class


//        todo add where

//        List<String> accFieldsList = new List<String>();
//        String selectStr = 'Id, Name, Industry, AnnualRevenue' + extraFields;
//        String query = 'SELECT '+ selectStr + ' FROM Account';
//        return Database.query(query);
//        return [
//            SELECT Id, Name, Industry, AnnualRevenue
//            FROM Account
//
//        ];


