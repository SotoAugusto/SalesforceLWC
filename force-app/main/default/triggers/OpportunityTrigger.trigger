trigger OpportunityTrigger on Opportunity (before insert, before update,
        after insert, after update, after delete, after undelete ){

    TriggerFactory.createHandler(Opportunity.SObjectType);

}