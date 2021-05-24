/**
 * Auto Generated and Deployed by the Declarative Lookup Rollup Summaries Tool package (dlrs)
 **/
trigger dlrs_kweos_EOCS_DataTrigger on kweos__EOCS_Data__c
    (before delete, before insert, before update, after delete, after insert, after undelete, after update)
{
    dlrs.RollupService.triggerHandler(kweos__EOCS_Data__c.SObjectType);
}