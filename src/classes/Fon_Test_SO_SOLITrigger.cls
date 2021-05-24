@isTest
public with sharing class Fon_Test_SO_SOLITrigger {
    static Boolean isInstalled = false;
    private static Contact con1 = new Contact();
    private static User portalAccountOwner;
         
    static testMethod void testSOTrigger() {    
        Fon_PackageScript.testInstall(); 
        Account acct = new Account();
        acct.Name = 'Test Account';
        insert acct;
        Contact con1 = new Contact();
        con1.LastName = 'LASTNAME';
        con1.AccountId = acct.Id;
        con1.Email ='testemail@testemail.com';
        insert con1;
       
        OrderApi__Business_Group__c BG1 =  new OrderApi__Business_Group__c();
        BG1.Name = 'BG1Name';
        insert BG1;

        OrderApi__Sales_Order__c so1 = new OrderApi__Sales_Order__c();
        so1.OrderApi__Contact__c = con1.ID;
        so1.OrderApi__Billing_Street__c = '4420 N fairfax Drive, Arlington, VA TEST data';
        so1.OrderApi__Billing_Country__c ='Congo';
        
        Test.startTest();
        
        insert so1;  
        update so1;
        Test.stoptest();
        
        list<OrderApi__Sales_Order__c> subs = [select id, FON_BillingStreet1__c, FON_BillingStreet2__c,name from OrderApi__Sales_Order__c];
        system.debug(subs);
        //system.assert(subs[0].FON_BillingStreet1__c!=null);
        
        }
        static testMethod void testSOLITrigger() {    
         Framework.Installer.install();
        PagesApi.PackageScripts.install();
        OrderApi.PackageScripts.install();
        //EventApi.PackageScripts.install();
        //CPBase.PackageScripts.install();
         new Fon_PackageScript.Install().run();
        //Fon_PackageScript.testInstall(); 
       /* Account acct = new Account();
        acct.Name = 'Test Account';
        insert acct;
        Contact con1 = new Contact();
        con1.LastName = 'LASTNAME';
        con1.AccountId = acct.Id;
        con1.Email ='testemail@testemail.com';
        insert con1;*/
       
        OrderApi__Business_Group__c BG1 =  new OrderApi__Business_Group__c();
        BG1.Name = 'BG1Name';
        insert BG1;

        OrderApi__Sales_Order__c so1 = new OrderApi__Sales_Order__c();
        //so1.OrderApi__Contact__c = con1.ID;
        //so1.OrderApi__Billing_Street__c = '4420 N fairfax Drive, Arlington, VA TEST data';
        insert so1;
        
        OrderApi__Item_Class__c itmc = new OrderApi__Item_Class__c();
        itmc.Name = 'Test Class';
        itmc.OrderApi__Is_Active__c = true;
        itmc.OrderApi__Business_Group__c = BG1.ID;
        insert itmc;
        system.debug('==='+itmc);
        OrderApi__Item__c itm = new OrderApi__Item__c();
        itm.OrderApi__Price__c = 100;
        itm.OrderApi__Item_Class__c = itmc.Id;
        itm.OrderApi__Business_Group__c = BG1.Id;
        itm.Name = 'test';
        
        insert itm; 
         system.debug('==='+itm);
        OrderApi__Sales_Order_Line__c soli = new OrderApi__Sales_Order_Line__c(OrderApi__Item__c = itm.id,OrderApi__Sales_Order__c = so1.id);
        insert soli;
        Test.startTest();
        soli.OrderApi__Shipping_Street__c='4420 N fairfax Drive, Arlington, VA TEST data';
        soli.OrderApi__Shipping_Country__c='Congo';
        update soli;
         
        Test.stoptest();
        list<OrderApi__Sales_Order_Line__c> subs = [select id, FON_ShippingStreet1__c , FON_ShippingStreet2__c ,name from OrderApi__Sales_Order_Line__c];
        
         //system.assert(subs[0].FON_ShippingStreet1__c!=null);  
        //cant test upgrade as it gives soql limit on creating so many objects and upgrades
        }

}