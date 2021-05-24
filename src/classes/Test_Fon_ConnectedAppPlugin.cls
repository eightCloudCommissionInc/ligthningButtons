@isTest
public with sharing class Test_Fon_ConnectedAppPlugin {
        
    @isTest
    static void testSAMLResponse() {
              
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        system.debug('portalRole is ' + portalRole);
        
        Profile profile1 = [Select Id from Profile where name = 'System Administrator'];
        User portalAccountOwner1 = new User(
        UserRoleId = portalRole.Id,
        ProfileId = profile1.Id,
        Username = 'test1234@fonteva.com',
        Alias = 'test1234',
        Email='test1234@fonteva.com',
        EmailEncodingKey='UTF-8',
        Firstname='Test',
        Lastname='Test1234',
        LanguageLocaleKey='en_US',
        LocaleSidKey='en_US',
        TimeZoneSidKey='America/Chicago'
        );
        
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs (thisUser) {
            Database.insert(portalAccountOwner1);
        
            //Create account
            Account portalAccount1 = new Account(
            Name = 'TestAccount',
            OwnerId = portalAccountOwner1.Id
            );
            Database.insert(portalAccount1);
            
            //Create contact
            Contact contact1 = new Contact(
            FirstName = 'Test',
            Lastname = 'Test4321',
            AccountId = portalAccount1.Id,
            Email = 'test4321@fonteva.com'
            );
            Database.insert(contact1);
            
            //Create user
            Profile portalProfile = [SELECT Id FROM Profile WHERE Name='Fonteva Customer Community Login User' Limit 1];
            User user1 = new User(
            Username = 'test12345@fonteva.com',
            ContactId = contact1.Id,
            ProfileId = portalProfile.Id,
            Alias = 'test123',
            Email = 'test12345@fonteva.com',
            EmailEncodingKey = 'UTF-8',
            LastName = 'test12345',
            CommunityNickname = 'test12345',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            LanguageLocaleKey = 'en_US'
            );
            Database.insert(user1);
            
            OrderApi__Business_Group__c bg = new OrderApi__Business_Group__c();
            bg.Name = 'Test BG';
            insert bg;
                
            OrderApi__Subscription_Plan__c subPlan = new OrderApi__Subscription_Plan__c();
            subPlan.Name = 'test subscription plan';
            subPlan.OrderApi__Type__c = 'Termed';
            subPlan.OrderApi__Initial_Term_Months__c = 12;
            subPlan.OrderApi__Renewal_Term_Months__c = 12;
            subPlan.OrderApi__Bill_Cycle__c = 'AUTO';
            subPlan.OrderApi__Auto_Renew_Option__c = 'Enabled';
            subPlan.OrderApi__Enable_Proration__c = false;
            subPlan.OrderApi__Is_Active__c = true;
            subPlan.OrderApi__Business_Group__c = bg.Id;
            insert subPlan;
    
            OrderApi__Item_Class__c itmClass = new OrderApi__Item_Class__c();
            itmClass.Name = 'Test Class';
            itmClass.OrderApi__Enable_Assignments__c = false;
            itmClass.OrderApi__Is_Subscription__c = true;
            itmClass.OrderApi__Assignment_SObject__c = 'TEST__C';
            itmClass.OrderApi__Is_Active__c = false;
            itmClass.OrderApi__Business_Group__c = bg.Id;
            itmClass.OrderApi__Is_Active__c = true;
            insert itmClass;
            
            OrderApi__Item__c itm = new OrderApi__Item__c();
            itm.Name = 'Test Item 1';
            itm.OrderApi__Is_Subscription__c = true;
            itm.OrderApi__Business_Group__c = bg.Id;
            itm.OrderApi__Item_Class__c = itmClass.Id;
            itm.OrderApi__Is_Active__c = false;
            itm.OrderApi__Price__c = 160;
            insert itm;
            
            OrderApi__Item_Subscription_Plan__c isp = new  OrderApi__Item_Subscription_Plan__c();
            isp.OrderApi__Is_Default__c = true;
            isp.OrderApi__Item__c = itm.Id;
            isp.OrderApi__Subscription_Plan__c = subPlan.Id;
            insert isp;
            itm.OrderApi__Is_Active__c = true;    
            update itm;
            
            OrderApi__Badge_Type__c badgeType = new OrderApi__Badge_Type__c();
            badgeType.Name = 'Gold';
            badgeType.OrderApi__Is_Active__c = true;
            badgeType.OrderApi__Is_Published__c = true;
            badgeType.Type__c = 'Subscriber';
            insert badgeType;    
              
            OrderAPi__Badge__c badge1 = new OrderAPi__Badge__c(OrderApi__badge_Type__c = badgeType.Id, OrderApi__Item__c = itm.Id,OrderApi__Contact__c = contact1.Id, OrderApi__Is_Active__c = true);
            insert badge1;
            
            Test.startTest(); 
               Fon_ConnectedAppPlugin cap = new Fon_ConnectedAppPlugin();
               cap.authorize(user1.id, Null, true, Null);
               cap.customAttributes(user1.id, Null, new Map<String,String>(), Null);
            Test.stopTest(); 
        }
         
    }
}