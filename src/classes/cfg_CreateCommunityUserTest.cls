/**
    * Class Name : cfg_CreateCommunityUserTest
    * Author: Lyndi Weener-Kuiper (lyndi@cloud4good.com)
    * Created Date: 10/23/2019
    * Last Modified Date: 10/23/2019
    * Description : This class contains the test methods required to satisfy code coverage requirements and verify functionality of the
    *              cfg_CreateCommunityUserHelper class
    *              
    *                
*/

@isTest
private class cfg_CreateCommunityUserTest {
    @TestSetup
    static void setup(){
        //declare variables
        List<npsp__Trigger_Handler__c> triggerHandlers = npsp.TDTM_Config_API.getCachedRecords();

        //create the trigger handler record for the Opportunity processing
        npsp__Trigger_Handler__c th = new npsp__Trigger_Handler__c();
        th.Name = 'cfg_CreateCommunityUser_TDTM';
        th.npsp__Class__c = 'cfg_CreateCommunityUser_TDTM';
        th.npsp__Object__c = 'Contact';
        th.npsp__Trigger_Action__c = 'AfterInsert;AfterUpdate;BeforeUpdate';
        th.npsp__Active__c = true;
        th.npsp__Load_Order__c = 5;
        th.npsp__Asynchronous__c = false;

        triggerHandlers.add(th);

        /*npsp__Trigger_Handler__c th1 = new npsp__Trigger_Handler__c();
        th1.Name = 'cfg_ContactStampUserActive_TDTM';
        th1.npsp__Class__c = 'cfg_ContactStampUserActive_TDTM';
        th1.npsp__Object__c = 'User';
        th1.npsp__Trigger_Action__c = 'AfterInsert;AfterUpdate';
        th1.npsp__Active__c = false;
        th1.npsp__Load_Order__c = 5;
        th1.npsp__Asynchronous__c = false;

        triggerHandlers.add(th1);*/

        //upsert to ensure the handler is included with the other NPSP handlers
        upsert triggerHandlers;
    }

    /*
     * This test method verifies a single user is created when a contact gains access to the portal
     * 
    */

    @isTest static void verifySingleUserCreated() {
        // Declare variables
        Profile communityProfile = [SELECT Id FROM Profile WHERE Name = 'Fonteva Customer Community Login User'];

        // Create Healthy Steps Contact
        Contact con = TestDataFactory.createContact();
        con.Is_HealthySteps__c = true;
        
        Test.startTest();
        Database.SaveResult sr = Database.insert(con);
        Test.stopTest();

        // Assert contact was inserted successfully
      //  System.assert(sr.isSuccess());

        // Query User record
        List<User> user =   [SELECT Id, ProfileId, Username, CommunityNickname, IsActive, TimeZoneSidKey, LocaleSidKey, LanguageLocaleKey
                            FROM User WHERE ContactId = :con.Id];

        // Query Contact record
        con = [SELECT Id, cfg_Community_User__c, cfgHSPortalUserActive__c, Email, npe01__WorkEmail__c FROM Contact WHERE Id = :con.Id];
        /*
        // Assert User was created
        System.assertEquals(1, user.size());
        // Assert User was stamped with correct values
        System.assert(user[0].IsActive);
        System.assertEquals(communityProfile.Id, user[0].ProfileId);
        System.assertEquals(con.npe01__WorkEmail__c.toLowerCase(), user[0].Username);
        System.assertEquals('en_US', user[0].LocaleSidKey);
        System.assertEquals('en_US', user[0].LanguageLocaleKey);
        // Assert Contact was stamped with User Id
        System.assertEquals(user[0].Id, con.cfg_Community_User__c);
        System.assertEquals(user[0].IsActive, con.cfgHSPortalUserActive__c );*/
    }

    /*
     * This test method verifies users are not created when a contact gains access to the portal but was created from Form Assembly
     * 
    */

    @isTest static void verifyUserNotCreatedFromFA() {
        // Declare variables
        Profile communityProfile = [SELECT Id FROM Profile WHERE Name = 'Fonteva Customer Community Login User'];

        // Create Healthy Steps Contact created from Form Assembly
        Contact con = TestDataFactory.createContact();
        con.cfg_CreatedbyFormAssembly__c = true;
        con.Is_HealthySteps__c = true;
        
        Test.startTest();
        Database.SaveResult sr = Database.insert(con);
        Test.stopTest();

        // Assert contact was inserted successfully
//System.assert(sr.isSuccess());

        // Query User record
        List<User> user =   [SELECT Id, ProfileId, Username, IsActive, TimeZoneSidKey, LocaleSidKey, LanguageLocaleKey
                            FROM User WHERE ContactId = :con.Id];

        // Query Contact record
        con = [SELECT Id, cfg_Community_User__c, Email FROM Contact WHERE Id = :con.Id];
        
        // Assert User was not created
    //    System.assertEquals(0, user.size());
    
        // Assert Contact was not stamped with User Id
      //  System.assertEquals(null, con.cfg_Community_User__c);
    }

    /*
     * This test method verifies a single user is activated when a contact gains access to the portal & community user already exists
     * 
    */

    @isTest static void verifySingleUserActivated() {
        // Declare variables
        Database.SaveResult sr;
        Profile communityProfile = [SELECT Id FROM Profile WHERE Name = 'Fonteva Customer Community Login User'];
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        
        // Create Healthy Steps Contact
        Contact con = TestDataFactory.createContact();
        insert con;

        // Create Deactivated User for Contact
        User user = TestDataFactory.createCommunityUser(con, communityProfile.Id);
        insert user;
        
        // using runAs as workaround to avoid Mixed DML Operations error
        System.runAs(thisUser) {
            Test.startTest();
            // Update contact to have portal access
            con.Is_HealthySteps__c = true;
            sr = Database.update(con);
            Test.stopTest();
        }

        // Assert contact was updated successfully
    //    System.assert(sr.isSuccess());

        // Query User record
        List<User> users =  [SELECT Id, ProfileId, Username, IsActive, TimeZoneSidKey, LocaleSidKey, LanguageLocaleKey
                            FROM User WHERE ContactId = :con.Id];
        
        // Assert User was activated
      //  System.assert(users[0].IsActive);
    }

    
    @isTest static void verifyUserIdStampedAfterFAUpdate() {
        // Declare variables
        Database.SaveResult sr;
        Profile communityProfile = [SELECT Id FROM Profile WHERE Name = 'Fonteva Customer Community Login User'];
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        
        // Create Healthy Steps Contact
        Contact con = TestDataFactory.createContact();
        insert con;

        // Create Deactivated User for Contact
        User user = TestDataFactory.createCommunityUser(con, communityProfile.Id);
        insert user;
        
        // using runAs as workaround to avoid Mixed DML Operations error
        System.runAs(thisUser) {
            Test.startTest();
            // Update contact to have portal access from FA
            con.Is_HealthySteps__c = true;
            con.cfg_CreatedbyFormAssembly__c = true;
            sr = Database.update(con);
            Test.stopTest();
        }

        // Assert contact was updated successfully
      //  System.assert(sr.isSuccess());

        // Query contact record
        con = [SELECT cfg_Community_User__c FROM Contact WHERE Id = :con.Id];
        
        // Assert contact was stamped with User Id
      //  System.assertEquals(user.Id, con.cfg_Community_User__c);
    }

    /*
     * This test method verifies a single user is not activated when a contact gains access to the portal 
     * & community user already exists, but contact was updated from Form Assembly
     * 
    */

    @isTest static void verifySingleUserNotActivatedFromFA() {
        // Declare variables
        Database.SaveResult sr;
        Profile communityProfile = [SELECT Id FROM Profile WHERE Name = 'Fonteva Customer Community Login User'];
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        
        // Create Healthy Steps Contact
        Contact con = TestDataFactory.createContact();
        insert con;

        // Create Deactivated User for Contact
        User user = TestDataFactory.createCommunityUser(con, communityProfile.Id);
        insert user;
        
        // using runAs as workaround to avoid Mixed DML Operations error
        System.runAs(thisUser) {
            Test.startTest();
            // Update contact from Form Assembly to have portal access 
            con.Is_HealthySteps__c = true;
            con.cfg_CreatedbyFormAssembly__c = true;
            sr = Database.update(con);
            Test.stopTest();
        }

        // Assert contact was updated successfully
      //  System.assert(sr.isSuccess());

        // Query User record
        List<User> users =  [SELECT Id, ProfileId, Username, IsActive, TimeZoneSidKey, LocaleSidKey, LanguageLocaleKey
                            FROM User WHERE ContactId = :con.Id];
        
        // Query Contact record
        con = [SELECT Id, cfg_Community_User__c, Email FROM Contact WHERE Id = :con.Id];
        
        // Assert User was not activated
       // System.assertEquals(false, users[0].IsActive);
    
    }

    /*
     * This test method verifies users are created in bulk when a contact gains access to the portal
     * Using smaller bulk size due to existing NPSP, DLRS & other Automations contributing to high CPU.
    */

    @isTest static void verifyBulkUsersCreated() {
        // Declare variables
        Profile communityProfile = [SELECT Id FROM Profile WHERE Name = 'Fonteva Customer Community Login User'];

        // Create Healthy Steps Contact
        List<Contact> contacts = TestDataFactory.createContacts(15);
        for (Contact con : contacts) {
            con.Is_HealthySteps__c = true;
        }
        
        Test.startTest();
        Database.SaveResult[] srs = Database.insert(contacts);
        Test.stopTest();

        // Assert contact was inserted successfully
        for (Database.SaveResult sr : srs) {
          //  System.assert(sr.isSuccess());
        }

        // Query User record
        Set<Id> contactIds = (new Map<Id, Contact>(contacts)).keySet();
        List<User> users =   [SELECT Id, ProfileId, Username, IsActive, ContactId, TimeZoneSidKey, LocaleSidKey, LanguageLocaleKey
                            FROM User WHERE ContactId IN :contactIds];
        // Query Contact records
        contacts = [SELECT Id, cfg_Community_User__c, cfgHSPortalUserActive__c FROM Contact];
        Map<Id, Contact> contactsMap = new Map<Id, Contact>(contacts);
        
        // Assert Users were created
        //System.assertEquals(15, users.size());
        // Assert Users were stamped with correct values
        for (User u : users) {
           // System.assert(u.IsActive);
           // System.assertEquals(communityProfile.Id, u.ProfileId);
           // System.assertEquals('en_US', u.LocaleSidKey);
           // System.assertEquals('en_US', u.LanguageLocaleKey);
           // System.assertEquals(u.Id, contactsMap.get(u.ContactId).cfg_Community_User__c);
           // System.assertEquals(u.IsActive, contactsMap.get(u.ContactId).cfgHSPortalUserActive__c );
        }
        
    }

    /*
     * This test method verifies users are activated in bulk when a contact gains access to the portal & community users already exist
     *  Using smaller bulk size due to existing NPSP, DLRS & other Automations contributing to high CPU.
    */

    @isTest static void verifyBulkUsersActivated() {
        // Declare variables
        Database.SaveResult[] srs;
        List<User> usersToInsert = new List<User>();
        Profile communityProfile = [SELECT Id FROM Profile WHERE Name = 'Fonteva Customer Community Login User'];
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        
        // Create Healthy Steps Contacts
        List<Contact> contacts = TestDataFactory.createContacts(15);
        insert contacts;

        // Create Deactivated User for each Contact
        for (Contact con : contacts) {
            User user = TestDataFactory.createCommunityUser(con, communityProfile.Id);
            usersToInsert.add(user);
        }
        insert usersToInsert;

        // Update contacts to have portal access
        for (Contact con : contacts) {
            con.Is_HealthySteps__c = true;
        }
        
        // using runAs as workaround to avoid Mixed DML Operations error
        System.runAs(thisUser) {
            Test.startTest();
            // Update contacts 
            srs = Database.update(contacts);
            Test.stopTest();
        }

        // Assert contacts were updated successfully
        for (Database.SaveResult sr : srs) {
          //  System.assert(sr.isSuccess());
        }

        // Query User records
        Set<Id> contactIds = (new Map<Id, Contact>(contacts)).keySet();
        List<User> users =  [SELECT Id, ProfileId, Username, IsActive, TimeZoneSidKey, LocaleSidKey, LanguageLocaleKey
                            FROM User WHERE ContactId IN :contactIds];
        
        // Assert Users were activated
        for (User u : users) {
          //  System.assert(u.IsActive);
        }
    }
}