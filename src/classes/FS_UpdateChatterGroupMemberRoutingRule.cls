/**
 * Created by dfitzgerald on 6/8/20.
 */

global without sharing class FS_UpdateChatterGroupMemberRoutingRule extends Framework.Domain {

    public FS_UpdateChatterGroupMemberRoutingRule(List<PagesApi__Community_Group_Member__c> sObjectList) {
        super(sObjectList);
    }

    global class Constructor implements Framework.Domain.DomainConstructor {
        global Framework.Domain construct(List<SObject> sObjectList) {
            return new FS_UpdateChatterGroupMemberRoutingRule(sObjectList);
        }
    }

    public override void beforeUpdate(Map<Id, SObject> existingRecords) {
        Framework.Log.push(FS_UpdateChatterGroupMemberRoutingRule.class.getName(), 'Before update');
        processCGMs((List<PagesApi__Community_Group_Member__c>) records, (Map<Id, PagesApi__Community_Group_Member__c>) existingRecords);
        Framework.Log.pop();
    }

    private void processCGMs(List<PagesApi__Community_Group_Member__c> cgms, Map<Id, PagesApi__Community_Group_Member__c> existingCGMs) {
        List<PagesApi__Community_Group_Member__c> cgmList = new List<PagesApi__Community_Group_Member__c>();
        for (PagesApi__Community_Group_Member__c cgm : cgms){
            if (existingCGMs.get(cgm.Id).PagesApi__Status__c != cgm.PagesApi__Status__c){
                cgmList.add(cgm);
            }
        }
        if (!cgmList.isEmpty()){
            FS_UpdateChatterGroupMemberClass.updateChatterGroupMember(cgmList);
        }
    }
}