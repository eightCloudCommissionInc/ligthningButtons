@isTest
Public class ReceiptEmailTemplateTest{
    
    static { Framework.Installer.install();
        }
    
    @isTest
    Private static  void sendEmailOnReceipt(){
       
        Account account = new Account(Name = 'Test', 
                BillingCity = 'Test', BillingStreet = 'Test', BillingPostalCode = '20852');
        insert account;
        
        Contact contact = new Contact(FirstName = 'Test', LastName = 'Test', AccountId = account.Id,email='test@gmail.com',
                 MailingCity = 'Test', MailingStreet = 'Test',
                MailingPostalCode = '20852');
        insert contact;
        
        OrderApi__Business_Group__c testBusinessGroup = new OrderApi__Business_Group__c();
        testBusinessGroup.Name = 'Test Buiness Group';
        insert testBusinessGroup;
        
        // I need an event category
        EventApi__Event_Category__c testEventCategory = new EventApi__Event_Category__c();
        testEventCategory.Name = 'Test Category';
        testEventCategory.EventApi__Business_Group__c = testBusinessGroup.Id;
        insert testEventCategory;
        
        EventApi__Event__c testEvent = new EventApi__Event__c ();
        testEvent.Name = 'Annual Conference 2019';
        testEvent.EventApi__Event_Key__c = 'TEST-EV001';
        testEvent.Event_Template__c = [select id,developerName from emailtemplate limit 1].developerName; 
        insert testEvent;
        
        OrderApi__Item_Class__c oItemClass = new OrderApi__Item_Class__c(Name = 'Membership', OrderApi__Is_Event__c=true);
        insert oItemClass;
        
        OrderApi__Item__c item = new OrderApi__Item__c(Name = 'Test', OrderApi__Item_Class__c = oItemClass.Id,
                OrderApi__Price__c = 50, OrderApi__Is_Active__c = true,OrderApi__Is_Event__c=true,EventApi__Event__c=testEvent.id);
        insert item;
        
        OrderApi__Sales_Order__c salesOrder = new OrderApi__Sales_Order__c(OrderApi__Account__c = account.Id,
                OrderApi__Contact__c = contact.Id, OrderApi__Posting_Entity__c = 'Receipt', OrderApi__Schedule_Type__c = 'Simple Invoice', OrderApi__Entity__c = 'Contact');
        insert salesOrder;
        
        OrderApi__Sales_Order_Line__c salesOrderLine = new OrderApi__Sales_Order_Line__c(OrderApi__Sales_Order__c = salesOrder.Id,
                OrderApi__Item__c = item.Id, OrderApi__Total__c = 50.00);
        insert salesOrderLine;
        
        salesOrder.OrderApi__Status__c = 'Closed';
        salesOrder.OrderApi__Posting_Status__c = 'Posted';
        update salesOrder;
        
        //Id recId = [select id from OrderApi__Receipt__c where OrderApi__Contact__c =:contact.id limit 1].Id;
        
        OrderApi__Receipt__c rec = new OrderApi__Receipt__c();
        rec.OrderApi__Payment_Type__c = 'Check';
        rec.OrderApi__Type__c = 'Payment';
        rec.OrderApi__Reference_Number__c = '12345';
        rec.OrderApi__Calculate_Memo__c = true;
        rec.OrderApi__Contact__c =contact.id; 
        
        insert (rec);

        OrderApi__Receipt_Line__c recLine = new OrderApi__Receipt_Line__c();
        recLine.OrderApi__Receipt__c = rec.Id;
        //recLine.Invoice__c = testRecord.Id;
        recLine.OrderApi__Sale_Price__c = 50;
        recLine.OrderApi__Quantity__c = 1;
        recLine.OrderApi__Item__c = item.id; 
        insert(recLine);
        
        Test.startTest();
        ReceiptEmailTemplate.sendEmail(new List<string>{rec.id});
        Test.stopTest();
    
    }
}