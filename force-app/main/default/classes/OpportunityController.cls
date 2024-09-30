public with sharing class OpportunityController {
    @AuraEnabled(Cacheable=true)
    public static List<AggregateResult> getOpportunitiesByAccount() {

        List<AggregateResult> opportunitiesList = [
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
        System.debug('Full List :' + opportunitiesList);

            Integer i = 0;
        for (SObject opp: opportunitiesList){
            System.debug('List Item ' + i);
            System.debug(opp);
            i++;
        }
        return opportunitiesList;
    }
}