//included for ZTT-13
global class FS_UpdateChatterGroupMemberBatchClass implements Database.Batchable<sObject>, Schedulable {
    global Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator([SELECT Id, PagesApi__Contact__c, PagesApi__Chatter_Group_Member_Id__c,
                PagesApi__Community_Group__c, PagesApi__Status__c FROM PagesApi__Community_Group_Member__c
        WHERE (PagesApi__Status__c = 'Active' AND PagesApi__Chatter_Group_Member_Id__c = NULL) OR
        (PagesApi__Status__c = 'Deactivated' AND PagesApi__Chatter_Group_Member_Id__c != NULL)]);
    }
    global void execute(Database.BatchableContext bc, List<PagesApi__Community_Group_Member__c> recordsToProcess){
        List<PagesApi__Community_Group_Member__c> groupMembersToUpdate = FS_UpdateChatterGroupMemberClass.updateChatterGroupMember(recordsToProcess);
        if(!groupMembersToUpdate.isEmpty()){
            update groupMembersToUpdate;
        }
    }
    global void finish(Database.BatchableContext bc){
    }
    global void execute(SchedulableContext sc){
        FS_UpdateChatterGroupMemberBatchClass cgmClass = new FS_UpdateChatterGroupMemberBatchClass();
        Id batchId = Database.executeBatch(cgmClass);

    }
}