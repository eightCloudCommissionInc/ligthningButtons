@isTest
public class Test_Fon_PushGTMCodeApex {
	String soId='/ZT3StagingCommunity/apex/lte__receiptinvoice?id=a3Q2f000000GiTzEAK&name=0000055837';
 	 @testSetup
    static void testSetup() {
        Account acct = new Account();
        acct.Name = 'Test Account';
        insert acct;
        
        Contact con1 = new Contact();
        con1.LastName = 'LASTNAME';
        con1.AccountId = acct.Id;
        con1.Email ='testemail@testemail.com';
        insert con1;   
        
        OrderApi__Sales_Order__c so1 = new OrderApi__Sales_Order__c();
        so1.OrderApi__Contact__c = con1.ID;
        so1.OrderApi__Billing_Street__c = '4420 N fairfax Drive, Arlington, VA TEST data';
        so1.OrderApi__Billing_Country__c ='Congo'; 
        //so1.OrderApi__Total__c ='1389';
        insert so1;
        
        OrderApi__Business_Group__c BG1 =  new OrderApi__Business_Group__c();
        BG1.Name = 'BG1Name';
        insert BG1;
        
        OrderApi__Item_Class__c itmc = new OrderApi__Item_Class__c();
        itmc.Name = 'Test Class';
        itmc.OrderApi__Is_Active__c = true;
        itmc.OrderApi__Business_Group__c = BG1.ID;
        insert itmc;

        OrderApi__Item__c itm = new OrderApi__Item__c();
        itm.OrderApi__Price__c = 100;
        itm.OrderApi__Item_Class__c = itmc.Id;
        itm.OrderApi__Business_Group__c = BG1.Id;
        itm.Name = 'test';
        insert itm; 

        OrderApi__Sales_Order_Line__c soli = new OrderApi__Sales_Order_Line__c();
        soli.OrderApi__Item__c = itm.id;
        soli.OrderApi__Sales_Order__c = so1.id;
        soli.OrderApi__Sale_Price__c=100;
        soli.OrderApi__Quantity__c=2;
        insert soli;
        
        OrderApi__Receipt__c recepit = new OrderApi__Receipt__c();
        //recepit.name='0000055837';
        recepit.OrderApi__Account__c = acct.id;
        recepit.OrderApi__Contact__c = con1.id;
        recepit.OrderApi__Sales_Order__c =so1.id;
        recepit.product_url__c='https://zttlms.zerotothree.org/my-dashboard';
        insert recepit;
    }
    static testMethod void method1(){ 
    OrderApi__Receipt__c receiptLine = [Select id,Name from OrderApi__Receipt__c limit 1];
        String retVal= Fon_PushGTMCodeApex.getOrderProducts(receiptLine.Name); 
    }   
    }