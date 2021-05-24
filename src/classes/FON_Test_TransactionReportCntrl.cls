@isTest
public with sharing class FON_Test_TransactionReportCntrl {
    static Boolean isInstalled = false;
    private static Contact con1 = new Contact();
    
    @testSetup static void createData() {
    
        Account acct = new Account();
        acct.Name = 'Test Account';
        insert acct;
        
        con1 = new Contact();
        con1.LastName = 'LASTNAME';
        con1.AccountId = acct.Id;
        con1.Email ='testemail@testemail.com';
        insert con1;
        
        OrderApi__Item_Class__c itmc = new OrderApi__Item_Class__c();
        itmc.Name = 'test item class';
        insert itmc;
        
        OrderApi__Item__c itm = new OrderApi__Item__c();
        itm.OrderApi__Item_Class__c = itmc.Id;
        itm.Name = 'test item';
        itm.OrderApi__Price__c = 10.00;
        itm.OrderApi__Cost__c = 10.00;
        insert itm;
        
        OrderApi__Sales_Order__c so = new OrderApi__Sales_Order__c();
        so.OrderApi__Contact__c = con1.Id;
        insert so;
        
        OrderApi__Sales_Order_Line__c sol = new OrderApi__Sales_Order_Line__c();
        sol.OrderApi__Sales_Order__c = so.Id;
        sol.OrderAPi__Item__c = itm.Id;
        insert sol;
        
        so.OrderApi__Status__c = 'Closed';
        update so;
        
        /**
        so.OrderApi__Posting_Status__c = 'Posted';
        update so;**/
        
        OrderApi__Receipt__c rec = new OrderApi__Receipt__c();
        rec.OrderApi__Contact__c = con1.Id;
        rec.OrderApi__Account__c = acct.Id;
        rec.OrderApi__Sales_Order__c = so.Id;
        insert rec;
        
        OrderApi__Receipt_Line__c rl = new OrderApi__Receipt_Line__c();
        rl.OrderApi__Item__c = itm.Id;
        rl.OrderApi__Receipt__c = rec.Id;
        insert rl;
        
        /**
        rec.OrderApi__Is_Posted__c = TRUE;
        update rec;
       **/
       
        OrderApi__Transaction__c tr = new OrderApi__Transaction__c();
        tr.OrderApi__Type__c = 'Cash';
        tr.OrderApi__Sales_Order__c = so.Id;
        tr.OrderApi__Receipt__c = rec.Id;
        tr.OrderApi__Date__c = system.today();
        tr.OrderApi__Receipt_Type__c = 'Payment';
        insert tr;
        
        OrderApi__Transaction_Line__c trl1 = new OrderApi__Transaction_Line__c();
        trl1.OrderApi__Transaction__c = tr.id;
        trl1.OrderApi__Receipt_Line__c = rl.Id;
        //trl1.OrderApi__Date__c = system.today();
        trl1.OrderApi__Receipt__c = rec.Id; 
        trl1.OrderApi__Item__c = itm.Id;
        trl1.OrderApi__Debit__c = 10.00;
        insert trl1;
        
        trl1 = new OrderApi__Transaction_Line__c();
        trl1.OrderApi__Transaction__c = tr.id;
        trl1.OrderApi__Receipt_Line__c = rl.Id;
        //trl1.OrderApi__Date__c = system.today();
        trl1.OrderApi__Receipt__c = rec.Id; 
        trl1.OrderApi__Item__c = itm.Id;
        trl1.OrderApi__Debit__c = 10.00;
        insert trl1;
    
    }
    
    static testMethod void testRunReport() {            
        Fon_PackageScript.testInstall();

        Test.startTest();
        string sDate = Datetime.now().addDays(-1).format('yyyy-MM-dd');
        string tDate = Datetime.now().addDays(1).format('yyyy-MM-dd');
        Test.setCurrentPageReference(new PageReference('/apex/TransReport?fDate='+sDate+'&tDate='+tDate));
        FON_TransactionReportCntrl ctr = new FON_TransactionReportCntrl();
        ctr.pageAction();
        string returnVal = ctr.xlsHeader;
        returnVal = ctr.type;
        List<string> returnVal0 = ctr.vals;
        Map<String, List<OrderApi__Transaction_Line__c>> returnVal1 = ctr.mapGLTL;
        Map<Date, List<OrderApi__Transaction_Line__c>> returnVal2 = ctr.mapDtTL;
       
        Test.stoptest();
           
    }

}