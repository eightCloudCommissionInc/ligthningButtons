@isTest
Public class SubscriptionTgrClsTest{
    public static Boolean isInstalled = false;
    public static  Contact contact;
    public  static  Account  account;
    public static  OrderApi__Subscription_Plan__c  subp;
    public static  OrderApi__Item__c item; 
    
    private static void install() {
        if (!isInstalled) {
            //Fon_PackageScripts.install();
            Framework.Installer.install();
            PagesApi.PackageScripts.install();
            OrderApi.PackageScripts.install();
            EventApi.PackageScripts.install();
            // Create a routing rule for Contact
            Framework.RoutingRule[] rules = new List<Framework.RoutingRule>();
            Framework.RoutingRule cons = new Framework.RoutingRule();
            cons.apexClass = Subscription_Trigger.class.getName();
            cons.namespace = '';
            cons.isEnabled = true;
            cons.sObjectName = 'OrderApi__Subscription__c';
            cons.executionOrder = 0;
            rules.add(cons);
            Framework.Config.push(rules);  
            
            
            isInstalled = true;
           
        }
    }
    
   /* @testSetup static void setup() {
        //install();
        
        account = new Account(Name = 'Test', 
                BillingCity = 'Test', BillingStreet = 'Test', BillingPostalCode = '20852');
        insert account;
        
        contact = new Contact(FirstName = 'Test', LastName = 'Test', AccountId = account.Id,email='test@gmail.com',
                 MailingCity = 'Test', MailingStreet = 'Test',
                MailingPostalCode = '20852');
        insert contact;
        
        OrderApi__Business_Group__c testBusinessGroup = new OrderApi__Business_Group__c();
        testBusinessGroup.Name = 'Test Buiness Group';
        insert testBusinessGroup;
        
       
        
        OrderApi__Item_Class__c oItemClass = new OrderApi__Item_Class__c(Name = 'Membership', OrderApi__Is_Subscription__c=true);
        insert oItemClass;
        
        item = new OrderApi__Item__c(Name = 'Test Membership', OrderApi__Item_Class__c = oItemClass.Id,
                OrderApi__Price__c = 50,OrderApi__Is_Subscription__c=true);
        insert item;
        
        subP = new OrderApi__Subscription_Plan__c();
        subP.Name = '1 Year';
        subP.OrderApi__Type__c = 'Termed';
        subP.OrderApi__Is_Active__c= true;
         subP.OrderApi__Initial_Term_Months__c = 12;
        insert subP;
        
        OrderApi__Item_Subscription_Plan__c planItem = new OrderApi__Item_Subscription_Plan__c(); 
        planItem.OrderApi__Is_Default__c = true;
        planItem.OrderApi__Item__c = item.id;
        planItem.OrderApi__Subscription_Plan__c = subP.Id;
       
        Insert  planItem;
        
        item.OrderApi__Is_Active__c  = true;
        update item;
        
    }*/
    
    @isTest(seeAlldata=true)
    Private static void SubscriptionTgrTest(){
        
        Framework.RoutingRule[] rules = new List<Framework.RoutingRule>();
        Framework.RoutingRule cons = new Framework.RoutingRule();
        cons.apexClass = Subscription_Trigger.class.getName();
        cons.namespace = ' ';
        cons.isEnabled = true;
        cons.sObjectName = 'OrderApi__Subscription__c';
        cons.executionOrder = 99;
        rules.add(cons);
        Framework.Config.push(rules);  
        
        account = new Account(Name = 'Test', 
                BillingCity = 'Test new 208521', BillingStreet = 'Test 5071', BillingPostalCode = '20852908');
        insert account;
        
        contact = new Contact(FirstName = 'Test', LastName = 'Test100', AccountId = account.Id,email='test1234@mailnator.com',
                 MailingCity = 'Test', MailingStreet = 'Test',
                MailingPostalCode = '20852');
        insert contact;
        
        OrderApi__Business_Group__c testBusinessGroup = new OrderApi__Business_Group__c();
        testBusinessGroup.Name = 'Test Buiness Group';
        insert testBusinessGroup;
        
       
        
        OrderApi__Item_Class__c oItemClass = new OrderApi__Item_Class__c(Name = 'Membership', OrderApi__Is_Subscription__c=true);
        insert oItemClass;
        
        item = new OrderApi__Item__c(Name = 'Test Membership', OrderApi__Item_Class__c = oItemClass.Id,
                OrderApi__Price__c = 50,OrderApi__Is_Subscription__c=true);
        insert item;
        
        subP = new OrderApi__Subscription_Plan__c();
        subP.Name = '1 Year';
        subP.OrderApi__Type__c = 'Termed';
        subP.OrderApi__Is_Active__c= true;
         subP.OrderApi__Initial_Term_Months__c = 12;
        insert subP;
        
        OrderApi__Item_Subscription_Plan__c planItem = new OrderApi__Item_Subscription_Plan__c(); 
        planItem.OrderApi__Is_Default__c = true;
        planItem.OrderApi__Item__c = item.id;
        planItem.OrderApi__Subscription_Plan__c = subP.Id;
       
        Insert  planItem;
        
        item.OrderApi__Is_Active__c  = true;
        update item;
        
        
        OrderApi__Subscription__c sub = new OrderApi__Subscription__c();
        sub.OrderApi__Account__c = account.Id;
        sub.OrderApi__Contact__c = contact.Id;
        sub.OrderApi__Entity__c='Contact';
        sub.OrderApi__Item__c =item.id;
        sub.OrderApi__Subscription_Plan__c=subP.id;
        sub.OrderApi__Status__c = 'Active';
        test.starttest();
        insert sub;
        
        //sub.OrderApi__Status__c = 'Cancelled';
        //update sub;
        test.stoptest();
    
    }
}