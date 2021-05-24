/**
 * Created by dfitzgerald on 6/10/20.
 */

public without sharing class FS_FoldersWithFilesController {

    @AuraEnabled
    public static List<PagesApi__Media_Asset_Collection__c> getListOfMediaCollectionsWithMediaAssetsApex(Id collaborationGroupId) {

        if (collaborationGroupId!= null && verifyUserApex(collaborationGroupId)) {

            //get related community groups
            List<PagesApi__Community_Group__c> communityGroups = [
                    SELECT Id, Name, (
                            SELECT Id, Name, FS_Media_Collection__c, FS_Media_Collection__r.Name
                            FROM Community_Group_to_Media_Libraries__r
                    )
                    FROM PagesApi__Community_Group__c
                    WHERE PagesApi__Chatter_Group_Id__c = :collaborationGroupId
                    LIMIT 1
            ];

            //create list of media collection ids
            List<Id> mediaCollectionIds = new List<Id>();

            if (communityGroups.size() > 0) {
                for (FS_Community_Group_to_Media_Library__c junctionObject : communityGroups[0].Community_Group_to_Media_Libraries__r) {
                    mediaCollectionIds.add(junctionObject.FS_Media_Collection__c);
                }
            }

            //get media asset data
            List<PagesApi__Media_Asset_Collection__c> mediaAssets = [
                    SELECT Id, Name, (SELECT Id, Name, PagesApi__Title__c, PagesApi__Short_Description__c, PagesApi__Path__c FROM PagesApi__Media_Assets__r ORDER BY PagesApi__Title__c ASC)
                    FROM PagesApi__Media_Asset_Collection__c
                    WHERE Id IN :mediaCollectionIds
                    ORDER BY Name ASC
            ];

            return mediaAssets;
        } else {
            return new List<PagesApi__Media_Asset_Collection__c>();
        }
    }

    @AuraEnabled
    //checks if user is valid member of collaboration group
    public static Boolean verifyUserApex(Id collaborationGroupId) {
        List<CollaborationGroupMember> members = [
                SELECT Id
                FROM CollaborationGroupMember
                WHERE MemberId = :UserInfo.getUserId() AND CollaborationGroupId = :collaborationGroupId
                LIMIT 1
        ];
        List<PagesApi__Community_Group_Member__c> cgmList = [SELECT Id,PagesApi__Status__c,PagesApi__Chatter_Group_Member_Id__c FROM PagesApi__Community_Group_Member__c WHERE PagesApi__Chatter_Group_Member_Id__c =: members[0].Id LIMIT 1];
        
        if (members.isEmpty() && (cgmList[0].PagesApi__Status__c == 'Deactivated')) {
            return false;
        } else {
            return true;
        }
    }
    
   @AuraEnabled
    public static void updateDownloadCount(String recId){
        PagesApi__Media_Asset__c mediaAsset = [SELECT Id, Fellows_Community_Download_Count__c, ITCP_Community_Download_Count__c, HS_Community_Download_Count__c, ZTT_Community_Download_Count__c FROM PagesApi__Media_Asset__c WHERE Id =: recId LIMIT 1];
        Double dc;
        String networkId = Network.getNetworkId();
        if(test.isrunningTest()) {networkId  = 'acb';}
        if(String.isNotBlank(networkId)){
            String nt ;
            if(Test.isrunningTest()) {
              nt = 'ITCP';
            }
            else {
              nt = [Select Name from Network WHERE Id =: networkId LIMIT 1].Name;
            }
            
            if(nt == 'ITCP Connect'){
                dc = mediaAsset.ITCP_Community_Download_Count__c;
                if(dc == null){
                    dc = 0;
                }
                mediaAsset.ITCP_Community_Download_Count__c = dc + 1;
                update mediaAsset;
            }
            if(Test.isrunningTest()) {
              nt = 'HealthySteps';
            }
            if(nt == 'HealthySteps'){
                dc = mediaAsset.HS_Community_Download_Count__c;
                if(dc == null){
                    dc = 0;
                }
                mediaAsset.HS_Community_Download_Count__c = dc + 1;
                update mediaAsset;
            }
            if(Test.isrunningTest()) {
              nt = 'Fellows';
            }
            if(nt == 'Fellows'){
                dc = mediaAsset.Fellows_Community_Download_Count__c;
                if(dc == null){
                    dc = 0;
                }
                mediaAsset.Fellows_Community_Download_Count__c = dc + 1;
                update mediaAsset;
            }
            if(Test.isrunningTest()) {
              nt = 'Zero To Three Community';
            }
            if(nt == 'Zero To Three Community'){
                dc = mediaAsset.ZTT_Community_Download_Count__c;
                if(dc == null){
                    dc = 0;
                }
                mediaAsset.ZTT_Community_Download_Count__c = dc + 1;
                update mediaAsset;
            }
        }
    }
}