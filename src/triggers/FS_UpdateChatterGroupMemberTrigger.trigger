//included for ZTT-13
trigger FS_UpdateChatterGroupMemberTrigger on PagesApi__Community_Group_Member__c (before update) {
    if(trigger.isBefore && trigger.isUpdate){
        List<PagesApi__Community_Group_Member__c> cgmList = new List<PagesApi__Community_Group_Member__c>();
        for(PagesApi__Community_Group_Member__c cgm : trigger.new){
            if(trigger.oldMap.get(cgm.Id).PagesApi__Status__c != cgm.PagesApi__Status__c){
                cgmList.add(cgm);
            }
        }
        if(!cgmList.isEmpty()){
            FS_UpdateChatterGroupMemberClass.updateChatterGroupMember(cgmList);
        }
    }
}