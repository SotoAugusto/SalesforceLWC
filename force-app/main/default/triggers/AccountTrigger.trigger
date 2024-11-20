/**
 * Created by jconforti on 8/2/24.
 */

trigger AccountTrigger on Account (before insert, before update,
        after insert, after update, after delete, after undelete ){

    TriggerFactory.createHandler(Account.SObjectType);

}