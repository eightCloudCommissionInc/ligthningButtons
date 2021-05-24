/**
 * Created by dfitzgerald on 8/19/20.
 */
@IsTest
public with sharing class FS_CommunityGroupHigherLogicRuleTest {

    @TestSetup
    private static void setup() {
        Framework.Installer.install();
        PagesApi.PackageScripts.install();
        OrderApi.PackageScripts.install();
        EventApi.PackageScripts.install();

        Framework.RoutingRule[] rules = new List<Framework.RoutingRule>();
        Framework.RoutingRule routingRule= new Framework.RoutingRule();
        routingRule.apexClass = FS_CommunityGroupHigherLogicRule.class.getName();
        routingRule.namespace = ' ';
        routingRule.isEnabled = true;
        routingRule.sObjectName = 'Contact';
        routingRule.executionOrder = 55;
        rules.add(routingRule);
        Framework.Config.push(rules);
    }

    @IsTest
    private static void testInsert() {
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
    }

    @IsTest
    private static void testUpdate() {
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

        con1.LastName = 'Testcontact1';
        update con1;
    }

    @IsTest
    private static void testCreateBadge() {

        List<FS_CommunityGroupITCPSetting__mdt> cgmSetting = [
                SELECT FS_CG_Site_Badge_Type_Id__c, FS_ITCP_Private_Community_Group_Id__c, FS_Trigger_Checkbox_Id__c
                FROM FS_CommunityGroupITCPSetting__mdt WHERE Label = 'DEFAULT'
        ];

        String Badge_Type_Id = cgmSetting[0].FS_CG_Site_Badge_Type_Id__c;
        String Community_Group_Id = cgmSetting[0].FS_ITCP_Private_Community_Group_Id__c;
        String checkboxId = cgmSetting[0].FS_Trigger_Checkbox_Id__c;

        Account acc = new Account();
        acc.Name = 'Test account';
        acc.Type = 'Member';
        acc.OrderApi__Account_Email__c = 'testAccount@gmail.com';
        insert acc;

        Contact con1 = new Contact();
        con1.LastName = 'Testcontact';
        con1.AccountId = acc.Id;
        con1.email = 'test@gmail.com';
        con1.cfg_Higher_Logic_Access__c = true;
        //con1.OrderApi__Is_Primary_Contact__c = true;
        insert con1;
        List<Id> contacts = new List<Id>();
        contacts.add(con1.Id);

        FS_CommunityGroupCheckboxBadgeService.createBadge(contacts, Badge_Type_Id);
    }

}