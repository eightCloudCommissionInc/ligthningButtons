/**
 * Created by daweima on 5/18/20.
 */

global without sharing class FS_CommunityGroupITCPFlagsRule extends Framework.Domain {
    public FS_CommunityGroupITCPFlagsRule(List<Contact> sObjectList){
        super(sObjectList); 
    }

    global class Constructor implements Framework.Domain.DomainConstructor {
        global Framework.Domain construct(List<SObject> sObjectList) {
            return new FS_CommunityGroupITCPFlagsRule(sObjectList);
        }
    }

    public override void afterInsert() {
        Framework.Log.push(FS_CommunityGroupITCPFlagsRule.class.getName(), 'afterInsert');
        
        for( FS_CommunityGroupITCPSetting__mdt cgmSetting :
                [SELECT FS_CG_Site_Badge_Type_Id__c, FS_ITCP_Private_Community_Group_Id__c, FS_Trigger_Checkbox_Id__c
                FROM FS_CommunityGroupITCPSetting__mdt]) {

          Id Badge_Type_Id = cgmSetting.FS_CG_Site_Badge_Type_Id__c;
          Id Community_Group_Id = cgmSetting.FS_ITCP_Private_Community_Group_Id__c;
          string checkboxId = cgmSetting.FS_Trigger_Checkbox_Id__c;
          FS_CommunityGroupCheckboxBadgeService.setCGMStatus(records, null, Community_Group_Id,checkboxId, Badge_Type_Id);
        }
        Framework.Log.pop();
    }

    public override void afterUpdate(Map<Id, SObject> oldMap) {
        Framework.Log.push(FS_CommunityGroupITCPFlagsRule.class.getName(), 'afterUpdate');
        System.debug('david itcp');
        for( FS_CommunityGroupITCPSetting__mdt cgmSetting :
                [SELECT FS_CG_Site_Badge_Type_Id__c, FS_ITCP_Private_Community_Group_Id__c, FS_Trigger_Checkbox_Id__c
                FROM FS_CommunityGroupITCPSetting__mdt]) {

          Id Badge_Type_Id = cgmSetting.FS_CG_Site_Badge_Type_Id__c;
          Id Community_Group_Id = cgmSetting.FS_ITCP_Private_Community_Group_Id__c;
          string checkboxId = cgmSetting.FS_Trigger_Checkbox_Id__c;
          FS_CommunityGroupCheckboxBadgeService.setCGMStatus(records, oldMap, Community_Group_Id,checkboxId, Badge_Type_Id);
        }
        System.debug('david itcp done');
        Framework.Log.pop();
    }

    private static Id Badge_Type_Id;
    private static Id Community_Group_Id;
    private static String checkboxId;
    static {

        List<FS_CommunityGroupITCPSetting__mdt> cgmSetting = [
                SELECT FS_CG_Site_Badge_Type_Id__c, FS_ITCP_Private_Community_Group_Id__c, FS_Trigger_Checkbox_Id__c
                FROM FS_CommunityGroupITCPSetting__mdt WHERE Label = 'DEFAULT'
        ];

        Badge_Type_Id = cgmSetting[0].FS_CG_Site_Badge_Type_Id__c;
        Community_Group_Id = cgmSetting[0].FS_ITCP_Private_Community_Group_Id__c;
        checkboxId = cgmSetting[0].FS_Trigger_Checkbox_Id__c;
    }
}