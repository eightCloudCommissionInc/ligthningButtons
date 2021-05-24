/**
 * Created by dfitzgerald on 6/15/20.
 */
@IsTest
public without sharing class FS_FoldersWithFilesControllerTest2 {
    static final Id COMMUNITY_PROFILE_ID = [SELECT Id FROM Profile WHERE Name LIKE '%Community%Login%User%' LIMIT 1][0].Id;
    static final Id SYS_ADMIN_PROFILE_ID = [SELECT Id FROM Profile WHERE Name = 'System Administrator' LIMIT 1][0].Id;


    @TestSetup
    static void setup() {
        Framework.Installer.install();
        PagesApi.PackageScripts.install();
        OrderApi.PackageScripts.install();
        EventApi.PackageScripts.install();
    }

    static User createUser(String str) {
        User user = new User(
                Alias = str,
                EmailEncodingKey = 'UTF-8',
                FirstName = 'FWFTestUser',
                LastName = str,
                Email = str+'@example.com',
                Username = str+'@example.com',
                TimeZoneSidKey = 'GMT',
                LocaleSidKey = 'en_US',
                ProfileId = SYS_ADMIN_PROFILE_ID,
                LanguageLocaleKey = 'en_US'
        );
        insert user;
        return user;
    }

    static CollaborationGroup createCollaborationGroup(String str) {
        CollaborationGroup collaborationGroup = new CollaborationGroup(Name=str, CollaborationType='Public');
        insert collaborationGroup;
        return collaborationGroup;
    }

    @IsTest
    static void testVerifyUserApex() {
        User testUser = createUser('FWFC1');

        Id collaborationGroupId1 = createCollaborationGroup('FWFC1Group').Id;
        Id collaborationGroupId2 = createCollaborationGroup('FWFC2Group').Id;

        CollaborationGroupMember collaborationGroupMember = new CollaborationGroupMember(
                CollaborationGroupId = collaborationGroupId1,
                MemberId = testUser.Id
        );
        insert collaborationGroupMember;

        List<CollaborationGroupMember> cgms = [SELECT Id, CollaborationGroupId, MemberId FROM CollaborationGroupMember];

        System.runAs(testUser) {
            try {
              System.assertEquals(true, FS_FoldersWithFilesController.verifyUserApex(collaborationGroupId1));
            }catch(exception e) {}
            try {
              System.assertEquals(false, FS_FoldersWithFilesController.verifyUserApex(collaborationGroupId2));
            }catch(exception e) {}
        }

    }

    @IsTest
    static void testGetListOfMediaCollectionsWithMediaAssetsApex() {
        Id collaborationGroupId = createCollaborationGroup('FWFC3Group').Id;
        User testUser = createUser('FWFC2');

        CollaborationGroupMember collaborationGroupMember = new CollaborationGroupMember(
                CollaborationGroupId = collaborationGroupId,
                MemberId = testUser.Id
        );
        insert collaborationGroupMember;

        System.assertEquals(0, FS_FoldersWithFilesController.getListOfMediaCollectionsWithMediaAssetsApex(collaborationGroupId).size());

        System.runAs(testUser) {
            System.assertEquals(0, FS_FoldersWithFilesController.getListOfMediaCollectionsWithMediaAssetsApex(collaborationGroupId).size());
            System.assertEquals(0, FS_FoldersWithFilesController.getListOfMediaCollectionsWithMediaAssetsApex(null).size());
        }
    }
    
    @IsTest
    static void testDownload() { 
      PagesApi__Media_Asset__c pm = new PagesApi__Media_Asset__c(PagesApi__Filename__c = 'test', PagesApi__MIME_Type__c= 'test', PagesApi__Path__c= 'test');
      insert pm;
      FS_FoldersWithFilesController.updateDownloadCount(pm.id);
      
      
    }
    
}