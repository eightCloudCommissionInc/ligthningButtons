/**
    * Class Name : cfg_CreateCommunityUserBatchTest
    * Author: Lyndi Weener-Kuiper (lyndi@cloud4good.com)
    * Created Date: 11/05/2019
    * Last Modified Date: 11/05/2019
    * Description : This class contains the test methods required to satisfy code coverage requirements and verify functionality of the
    *              cfg_CreateCommunityUserBatch class
    *              
    * 				 
*/
@isTest
private class cfg_CreateCommunityUserBatchTest {

    /*
     * This test method verifies community users are created in bulk from batch
     * Using smaller bulk size due to existing NPSP, DLRS & other Automations contributing to high CPU.
    */

    @isTest static void verifyBulkUsersCreated() {
        // Declare variables
        Profile communityProfile = [SELECT Id FROM Profile WHERE Name = 'Fonteva Customer Community Login User'];

        // Create Healthy Steps Contact created from Form Assembly
        List<Contact> contacts = TestDataFactory.createContacts(25);
        for (Contact con : contacts) {
            con.Is_HealthySteps__c = true;
            con.cfg_CreatedbyFormAssembly__c = true;
        }
        insert contacts;
        
        Test.startTest();
        // Execute scheduled class
        cfg_CreateCommunityUserBatch batchJob = new cfg_CreateCommunityUserBatch();
        Database.executeBatch(batchJob);
        Test.stopTest();

        // Query User records
        Set<Id> contactIds = (new Map<Id, Contact>(contacts)).keySet();
        List<User> users =   [SELECT Id, ProfileId, Username, IsActive, ContactId, TimeZoneSidKey, LocaleSidKey, LanguageLocaleKey
                            FROM User WHERE ContactId IN :contactIds];
                            system.debug('testUsers ' + users);
        // Query Contact records
        contacts = [SELECT Id, cfg_Community_User__c, cfg_CreatedbyFormAssembly__c FROM Contact];
                        system.debug('testContacts ' + contacts);
        Map<Id, Contact> contactsMap = new Map<Id, Contact>(contacts);
        
        // Assert Users were created
        System.assertEquals(25, users.size());
        // Assert Users were stamped with correct values
        for (User u : users) {
            System.assert(u.IsActive);
            System.assertEquals(communityProfile.Id, u.ProfileId);
            System.assertEquals('en_US', u.LocaleSidKey);
            System.assertEquals('en_US', u.LanguageLocaleKey);
            System.assertEquals(u.Id, contactsMap.get(u.ContactId).cfg_Community_User__c);
        }
        // Assert Contacts were updated to have cfg_CreatedbyFormAssembly = false
        for (Contact con : contacts) {
            System.assertEquals(false, con.cfg_CreatedbyFormAssembly__c);
        }
        
    }

    /*
     * This test method adds coverage for cfg_SendWelcomeLetterSchedulable class
     * 
    */
    @isTest static void verifyScheduler() {
        Test.startTest();
        cfg_CreateCommunityUserSchedulable scheduledJob = new cfg_CreateCommunityUserSchedulable();
        String schTime = '20 30 8 10 2 ?';
        String jobID = System.schedule('Test Send Community User Batch', schTime, scheduledJob);
        Test.stopTest();

        System.assertNotEquals(null, jobID);
    }
}