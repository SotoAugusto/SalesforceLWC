public class AccountController {
    @AuraEnabled
    public static List<Account> getAccounts(Map<String, String> whereClauses) {
        // combine default fields with the fields the user added
        List<String> defaultFields = new List<String>{
                'Id', 'Name', 'Industry', 'AnnualRevenue'
        };
        defaultFields.addAll(whereClauses.keySet());

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
    @AuraEnabled
    public static void updateAccounts(List<Account> accountsForUpdate) {
        update accountsForUpdate;
    }
}//end class


