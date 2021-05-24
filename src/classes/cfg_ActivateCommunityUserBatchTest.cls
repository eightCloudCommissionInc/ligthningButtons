/**
    * Class Name : cfg_ActivateCommunityUserBatchTest
    * Author: Lyndi Weener-Kuiper (lyndi@cloud4good.com)
    * Created Date: 1/15/2020
    * Last Modified Date: 1/15/2020
    * Description : This class contains the test methods required to satisfy code coverage requirements and verify functionality of the
    *              cfg_ActivateCommunityUserBatch class
    *              
    *                
*/
@isTest
private class cfg_ActivateCommunityUserBatchTest {
    
    /*
     * This test method verifies community users are activated in bulk from batch.
     * Using smaller bulk size due to existing NPSP, DLRS & other Automations contributing to high CPU.
    */

    @isTest static void verifyBulkUsersActivated() {
        // Declare variables
        List<User> usersToInsert = new List<User>();
        Profile communityProfile = [SELECT Id FROM Profile WHERE Name = 'Fonteva Customer Community Login User'];
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        
        // Create Healthy Steps Contacts
        List<Contact> contacts = TestDataFactory.createContacts(10);
        insert contacts;

        // Create Inactive Users for each Contact
        for (Contact con : contacts) {
            User user = TestDataFactory.createCommunityUser(con, communityProfile.Id);
            usersToInsert.add(user);
        }
        // make one user active to hit reset password logic
        usersToInsert[0].IsActive = true;
        insert usersToInsert;

        // Update contacts to have portal access via form assembly & be linked to an existing inactive user
        List<Contact> contactsToUpdate = new List<Contact>();
        for (Integer i = 0; i < contacts.size(); i++) {
            Contact con = contacts[i];
            con.Is_HealthySteps__c = true;
            con.cfg_CreatedbyFormAssembly__c = true;
            con.cfg_Community_User__c = usersToInsert[i].Id;
            contactsToUpdate.add(con);
        }
        update contactsToUpdate;
        

        // using runAs as workaround to avoid Mixed DML Operations error
        System.runAs(thisUser) {
            Test.startTest();
            // Execute scheduled class
            cfg_ActivateCommunityUsersBatch scheduledJob = new cfg_ActivateCommunityUsersBatch();
            String schTime = '20 30 8 10 2 ?';
            String jobID = System.schedule('Test Create Community User Batch', schTime, scheduledJob);
            Test.stopTest();
        }

        // Query User records
        Set<Id> contactIds = (new Map<Id, Contact>(contacts)).keySet();
        List<User> users =  [SELECT Id, ProfileId, Username, IsActive, TimeZoneSidKey, LocaleSidKey, LanguageLocaleKey
                            FROM User WHERE ContactId IN :contactIds];
        // Query contact records
        contacts = [SELECT Id, cfg_Community_User__c, cfg_CreatedbyFormAssembly__c FROM Contact];
        
        // Assert Users were activated
        for (User u : users) {
            System.assert(u.IsActive);
        }

         // Assert Contacts were updated to have cfg_CreatedbyFormAssembly = false
        for (Contact con : contacts) {
            System.assertEquals(false, con.cfg_CreatedbyFormAssembly__c);
        }
    }
    
    @isTest static void verifyBulkUsersActivated1() { 
      List<Contact> contacts = TestDataFactory.createContacts(1);
        insert contacts;
      cfg_CreateCommunityUserHelper.checkForExistingUsers  (contacts);
      cfg_CreateCommunityUserHelper.resetPasswords (new set<id>{userinfo.getuserid()});
      cfg_CreateCommunityUserHelper.updateExistingUsersFuture(new set<id>{userinfo.getuserid()});
      cfg_CreateCommunityUserHelper.updateContactUserId(contacts);
      cfg_CreateCommunityUserHelper.createLog('abc',contacts[0].id,userinfo.getuserid(),new list<Database.Error>());
    }
}