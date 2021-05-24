/**
 * Created by dfitzgerald on 6/8/20.
 */
//adapted from FS_UpdateChatterGroupMemberTriggerTest
@IsTest
public without sharing class FS_UpdateChatterGroupMemberRRTest {

    @TestSetup
    private static void setup() {
        Framework.Installer.install();
        PagesApi.PackageScripts.install();
        OrderApi.PackageScripts.install();
        EventApi.PackageScripts.install();

        Framework.RoutingRule[] rules = new List<Framework.RoutingRule>();
        Framework.RoutingRule routingRule= new Framework.RoutingRule();
        routingRule.apexClass = FS_UpdateChatterGroupMemberRoutingRule.class.getName();
        routingRule.namespace = ' ';
        routingRule.isEnabled = true;
        routingRule.sObjectName = 'PagesApi__Community_Group_Member__c';
        routingRule.executionOrder = 55;
        rules.add(routingRule);
        Framework.Config.push(rules);
    }

    @isTest private static void updateChatterGmForRR(){
        OrderApi__Business_Group__c businessGroup = new OrderApi__Business_Group__c();
        businessGroup.Name = 'test business group';
        insert businessGroup;

        Account acc = new Account();
        acc.Name = 'Test account';
        acc.Type = 'Member';
        acc.OrderApi__Account_Email__c = 'testAccount@gmail.com';
        insert acc;

        Contact con1 = new Contact();
        con1.LastName = 'Testcontact';
        con1.AccountId = acc.Id;
        con1.email = 'test@gmail.com';
        //con1.OrderApi__Is_Primary_Contact__c = true;
        insert con1;

        Account a = [SELECT Id, OrderApi__Primary_Contact__c FROM Account WHERE Id =: acc.Id];
        a.OrderApi__Primary_Contact__c = con1.Id;
        update a;

        Id profileId = [SELECT Id, Name FROM Profile WHERE Name LIKE 'Fonteva%Customer%Community%User' LIMIT 1][0].Id;

        User communityUser = new User();
        communityUser.Alias = 'test123';
        communityUser.Email = 'test123@gmail.com';
        communityUser.EmailEncodingKey = 'UTF-8';
        communityUser.LastName = 'Testing';
        communityUser.LanguageLocaleKey = 'en_US';
        communityUser.LocaleSidKey = 'en_US';
        communityUser.ProfileId = profileId;
        communityUser.Country = 'United States';
        communityUser.IsActive = true;
        communityUser.ContactId = con1.Id;
        communityUser.TimeZoneSidKey = 'America/Los_Angeles';
        communityUser.Username = 'tester@noemail.com';
        insert communityUser;

        PagesApi__Community_Group__c communityGroup = new PagesApi__Community_Group__c();
        communityGroup.Name = 'test';
        communityGroup.PagesApi__Type__c = 'Section';
        insert communityGroup;

        PagesApi__Community_Group__c cgr = [SELECT Id, PagesApi__Chatter_Group_Id__c FROM
                PagesApi__Community_Group__c WHERE Id =: communityGroup.Id];
        Contact c2 = [SELECT Id FROM Contact WHERE Id =:con1.Id];


        PagesApi__Community_Group_Member__c communityGroupMember = new PagesApi__Community_Group_Member__c();
        communityGroupMember.PagesApi__Contact__c = c2.Id;
        communityGroupMember.PagesApi__Is_Active__c = true;
        communityGroupMember.PagesApi__Status__c = 'Active';
        communityGroupMember.PagesApi__Community_Group__c = cgr.Id;
        insert communityGroupMember;

        communityGroupMember.PagesApi__Status__c = 'Deactivated';
        update communityGroupMember;
        List<PagesApi__Community_Group_Member__c> cgmListTest = new List<PagesApi__Community_Group_Member__c>();
        //cgmListTest.add();
    }
}