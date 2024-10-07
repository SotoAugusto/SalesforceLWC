public with sharing class OpportunityController {
    @AuraEnabled(Cacheable=true)
    public static List<AccountOpportunityData> getAccountOppStats() {

        List<AggregateResult> AccountOppStats = [
                SELECT
                        Account.Id,
                        Account.Name,
                        SUM(Account.AnnualRevenue) AnnualRevenueSum,
                        COUNT(Opportunity.Id) TotalOpportunities,
                        SUM(Opportunity.Amount) TotalOpportunityAmount,
                        MAX(Opportunity.Amount) MaxOpportunityAmount,
                        AVG(Opportunity.Amount) AvgRevenuePerOpportunity
                FROM
                        Opportunity
                GROUP BY
                        Account.Id,
                        Account.Name
        ];

//        {
//         "Id": "001ak00000LxPGCAA3",
//        "Name": "GenePoint",
//        "AnnualRevenueSum": 90000000,
//        "TotalOpportunities": 3,
//        "TotalOpportunityAmount": 175000,
//        "MaxOpportunityAmount": 85000,
//         "AvgRevenuePerOpportunity": 58333.333333333336
//        }

        System.debug('AccountOppStats: ' + AccountOppStats);


        //now i need to also bring Opportunities that match with the account id, bring fields Name and Amount

        // save id's on a set
        Set<Id> accountIds = new Set<Id>();
//        create a list from my wrapper
        List<AccountOpportunityData> accountsWithOppListWrapper = new List<AccountOpportunityData>();

//        go through AccountOppStats and extract all Id's
        for (AggregateResult currentResultAccount : AccountOppStats) {
//            create new object from my wrapper class
            AccountOpportunityData combinedData = new AccountOpportunityData(currentResultAccount);
            accountsWithOppListWrapper.add(combinedData);
            System.debug('current saved combinedData: ' + combinedData);
//            AccountOpportunityData:[accountId=001ak00000LxPGCAA3, accountName=GenePoint, annualRevenueSum=9.0E+7, avgRevenuePerOpportunity=58333.333333333336, maxOpportunityAmount=85000.00, opportunities=(), totalOpportunities=3, totalOpportunityAmount=175000.0]
            //parse as ID, add id to the set
            accountIds.add((Id) currentResultAccount.get('Id'));
            System.debug('current saved id to accountIds: ' + accountIds);
        }
//        {001ak00000LxPG2AAN, 001ak00000LxPG3AAN, 001ak00000LxPGCAA3}

        System.debug('accountIds: ' + accountIds);
// fill a list of all opportunities grouped by the accountId Set
        List<Opportunity> opportunitiesByAccount = [
                SELECT
                        AccountId, Name, Amount
                FROM
                        Opportunity
                WHERE AccountId IN :accountIds
        ];

        System.debug('opportunitiesByAccount: ' + opportunitiesByAccount);

//        Map, key: accountID , opportunities list
        Map<Id, List<Opportunity>> opportunitiesMap = new Map<Id, List<Opportunity>>();

//        go through opportunitiesByAccount to fill map
        for (Opportunity currentOpp : opportunitiesByAccount) {
//            prevent to create more than one key per accountID (guard if)
            if (!opportunitiesMap.containsKey(currentOpp.AccountId)) {
//                create a new list for this account Id
                opportunitiesMap.put(currentOpp.AccountId, new List<Opportunity>());
            }
//            attach current opportunity to a key (account ID)
            opportunitiesMap.get(currentOpp.AccountId).add(currentOpp);
            System.debug('currentOpp  ' + currentOpp);
        }
        System.debug('opportunitiesMap' + opportunitiesMap);

//        iterate the list of accountsWithOppListWrapper
        for (AccountOpportunityData currentAccountWithOpp : accountsWithOppListWrapper) {
            // check if opportunitiesMap has info on that account Id
            if (opportunitiesMap.containsKey(currentAccountWithOpp.accountId)) {
//                then attach the list of opportunities to the opp field of the current AccountOpportunityData object
                currentAccountWithOpp.opportunities = opportunitiesMap.get(currentAccountWithOpp.accountId);
            }
        }
        System.debug('Final accountsWithOppListWrapper: ' + accountsWithOppListWrapper);
        return accountsWithOppListWrapper;
        // how can i return a single data structure with AccountOppStats + opportunitiesByAccount ?
        // implement the wrapper to create a map

    }//end function


//wrapper
    public class AccountOpportunityData {
        @AuraEnabled public Id accountId;
        @AuraEnabled public String accountName;
        @AuraEnabled public Decimal annualRevenueSum;
        @AuraEnabled public Integer totalOpportunities;
        @AuraEnabled public Decimal totalOpportunityAmount;
        @AuraEnabled public Decimal maxOpportunityAmount;
        @AuraEnabled public Decimal avgRevenuePerOpportunity;
        @AuraEnabled public List<Opportunity> opportunities;

//        constructor
        public AccountOpportunityData(AggregateResult accountWithOpp) {
            this.accountId = (Id) accountWithOpp.get('Id');
            System.debug(this.accountId);
            this.accountName = (String) accountWithOpp.get('Name');
            this.annualRevenueSum = (Decimal) accountWithOpp.get('AnnualRevenueSum');
            this.totalOpportunities = (Integer) accountWithOpp.get('TotalOpportunities');
            this.totalOpportunityAmount = (Decimal) accountWithOpp.get('TotalOpportunityAmount');
            this.maxOpportunityAmount = (Decimal) accountWithOpp.get('MaxOpportunityAmount');
            this.avgRevenuePerOpportunity = (Decimal) accountWithOpp.get('AvgRevenuePerOpportunity');
            this.opportunities = new List<Opportunity>();
        }
    }// end class AccountOpportunityData
}//enc OpportunityController class