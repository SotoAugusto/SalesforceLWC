// after insert, because we need a Account ID for the Opportunity relationship
trigger CreateAccountOpportunity on Account (after insert) {

    // - Trigger que al momento de crear una cuenta se creara una oportunidad, relacionar ambos records.
    // when creating a Account, create an Opportunity and relate both records

    //create a list of Opportunities
    List<Opportunity> oppList = new List<Opportunity>();
    for (Account acc : Trigger.new) {
        // create opp object
        Opportunity oppObj = new Opportunity();
        oppObj.Name = 'Opportunity for ' + acc.Name;
        oppObj.StageName = 'Prospecting';
        oppObj.CloseDate = System.today();
        oppObj.AccountId = acc.Id;
        oppList.add(oppObj);
    }
    System.debug('oppList: ' + oppList);
    if (!oppList.isEmpty()
        && Opportunity.SObjectType.getDescribe().isAccessible()
        && Opportunity.sObjectType.getDescribe().isCreateable()
        && Opportunity.sObjectType.getDescribe().isUpdateable()
        ) {
            insert oppList;
    }
    // add error?


}