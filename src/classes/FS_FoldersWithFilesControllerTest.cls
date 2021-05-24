/**
 * Created by dfitzgerald on 6/15/20.
 */
@IsTest
public without sharing class FS_FoldersWithFilesControllerTest {
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

    @IsTest
    static void testVerifyUserApex() {
        User testUser = createUser('FWFC1');

        //Id collaborationGroupId1 = '0F92f000000CnKRCA0';
        //Id collaborationGroupId2 = '0F92f000000CnKRCA4';
        CollaborationGroup collaborationGroup1 = new CollaborationGroup(Name='FWFC1Group');
        CollaborationGroup collaborationGroup2 = new CollaborationGroup(Name='FWFC2Group');
        insert collaborationGroup1;
        insert collaborationGroup2;

        Id collaborationGroupId1 = collaborationGroup1.Id;
        Id collaborationGroupId2 = collaborationGroup2.Id;

        CollaborationGroupMember collaborationGroupMember = new CollaborationGroupMember(
                CollaborationGroupId = collaborationGroupId1,
                MemberId = testUser.Id
        );
        insert collaborationGroupMember;

        List<CollaborationGroupMember> cgms = [SELECT Id, CollaborationGroupId, MemberId FROM CollaborationGroupMember];

        System.runAs(testUser) {
            System.assertEquals(true, FS_FoldersWithFilesController.verifyUserApex(collaborationGroupId1));
            System.assertEquals(false, FS_FoldersWithFilesController.verifyUserApex(collaborationGroupId2));
        }

    }

    //@IsTest
    static void testGetListOfMediaCollectionsWithMediaAssetsApex() {
        Id collaborationGroupId = '0F92f000000CnKRCA0';
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

}