@IsTest
private class Fon_TestJPDupMemberCtrl {
    
    static joinapi__Join_Process__c jp = new joinapi__Join_Process__c();
    static joinapi__Step__c sp = new joinapi__Step__c();
    private static Account acct = new Account();
    private static Account acct1 = new Account();
    private static Contact con1 = new Contact();
    private static Contact con2 = new Contact();
    private static list<OrderApi__Item__c> allItems = new list<OrderApi__Item__c>();
    private static User portalAccountOwner;
    private static User portalAccountOwner1;
    
    static void buildData() {
        Framework.Dispatcher.disableTriggerInContext.put('Account',true);
        Framework.Dispatcher.disableTriggerInContext.put('Contact',true);
        Framework.Dispatcher.disableTriggerInContext.put('OrderApi__Subscription_Plan__c',true);
        //Fon_TestUtil.BasicObjectCreation();
        
        acct = new Account();
        acct.Name = 'Test Account';
        insert acct;
        
        acct1 = new Account();
        acct1.Name = 'Test Account';
        insert acct1;
        
        con1 = new Contact();
        con1.LastName = 'LASTNAME';
        con1.AccountId = acct.Id;
        con1.Email ='testemail@testemail.com';
        insert con1;
        
        con2 = new Contact();
        con2.LastName = 'LASTNAME1';
        con2.AccountId = acct1.Id;
        con2.Email ='testemail1@testemail.com';
        insert con2;
        
        Id p = [select id from profile where name LIKE '%Fonteva Customer Community Login User%' limit 1].id;
        portalAccountOwner = new User(      
            ProfileId = p,
            Username = 'billst45@test.com',
            Alias = 'tu204',
            Email='test@test.com',
            EmailEncodingKey='UTF-8',
            Firstname='tu',
            Lastname='twoOfour',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            TimeZoneSidKey='America/Chicago',
            ContactId =con1.id
        );
        insert portalAccountOwner;
        
        portalAccountOwner1 = new User(      
            ProfileId = p,
            Username = 'abc@test.com',
            Alias = 'tu204',
            Email='test@test.com',
            EmailEncodingKey='UTF-8',
            Firstname='tu',
            Lastname='twoOfour',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            TimeZoneSidKey='America/Chicago',
            ContactId =con2.id
        );
        insert portalAccountOwner1;
        
        OrderApi__Business_Group__c BG1 =  new OrderApi__Business_Group__c();
        BG1.Name = 'BG1Name';
        insert BG1;
        
        OrderApi__Item_Class__c itmc = new OrderApi__Item_Class__c();
        itmc.Name = 'Test Class';
        itmc.OrderApi__Is_Subscription__c=true;
        itmc.OrderApi__Is_Active__c = true;
        itmc.OrderApi__Business_Group__c = BG1.ID;
        insert itmc;
        
        OrderApi__Item__c itm = new OrderApi__Item__c();
        itm.OrderApi__Price__c = 100;
        itm.OrderApi__Item_Class__c = itmc.Id;
        itm.OrderApi__Business_Group__c = BG1.Id;
        itm.Name = 'test';
        allItems.add(itm);
        
        insert allItems;
        
        OrderApi__Subscription_Plan__c plan = new OrderApi__Subscription_Plan__c();
        plan.OrderApi__Type__c = 'Termed';
        plan.OrderApi__Initial_Term_Months__c = 12;
        plan.OrderApi__Is_Active__c = true;
        plan.OrderApi__Business_Group__c = BG1.Id;
        insert plan;
        
        OrderApi__Subscription__c sub = new OrderApi__Subscription__c();
        sub.OrderApi__Item__c = itm.Id;
        sub.OrderApi__Subscription_Plan__c=plan.id;
        sub.OrderApi__Is_Active__c=true;
        sub.OrderApi__Contact__c =con1.id;
        insert sub;
        
        jp.joinapi__Join_Process_Display_Name__c = 'Test';
        jp.joinapi__Is_Published__c = true;
        jp.joinapi__Landing_Url__c = 'https://staging-myzerotothree.cs34.force.com/ZT3StagingCommunity/joinapi__login?id=a4If4000000hAs3EAE&order=1';
        insert jp;
        
        joinapi__Step__c sp1 = new joinapi__Step__c();
        sp1.joinapi__Join_Process__c = jp.Id;
        insert sp1;
        
        sp.joinapi__Join_Process__c = jp.Id;
        sp.joinapi__Page_Title__c = 'test';
        sp.joinapi__Next_Step__c = sp1.Id;
        sp.joinapi__Next_Step_Button_Label__c = 'test';
        sp.joinapi__Instructions__c = 'test';
        sp.joinapi__Is_First_Step__c = true;
        sp.joinapi__Is_Custom_Page__c = true;
        
        sp.joinapi__Visual_Force_Page_API_Name__c = 'Fon_JPDupMember';
        insert sp;
        
        joinapi__Step__c sp2 = new joinapi__Step__c();
        sp2.joinapi__Join_Process__c = jp.Id;
        sp2.joinapi__Next_Step__c = sp.Id;
        sp2.joinapi__Is_First_Step__c = TRUE;
        insert sp2;
        
    }
    
    static testMethod void testNoDuplicate() {
        buildData();
        System.runAs(portalAccountOwner) {
            Test.setCurrentPageReference(new PageReference('Page.Fon_JPDupMember'));
            System.currentPageReference().getParameters().put('id', sp.Id);
            List<OrderApi__Subscription__c> subs = [select id,OrderApi__Contact__c,OrderApi__Is_Active__c from OrderApi__Subscription__c where OrderApi__Contact__c =:con1.id AND OrderApi__Is_Active__c = true];
            //system.debug('===='+subs);
            Fon_JPDupMemberCtrl controller = new Fon_JPDupMemberCtrl();        
            controller.cancelStep();
            Test.startTest();
            PageReference p = controller.checkDuplicate();
            //system.debug('==='+p);
            Test.stopTest();
            system.assert(controller.allowRenew == true);
            
        }
    }
    
    static testMethod void testDuplicateAllowNew() {
        buildData();
        System.runAs(portalAccountOwner) {
            Test.setCurrentPageReference(new PageReference('Page.Fon_JPDupMember'));
            System.currentPageReference().getParameters().put('id', sp.Id);
            Fon_JPDupMemberCtrl controller = new Fon_JPDupMemberCtrl();       
            controller.cancelStep();
            Test.startTest();
            PageReference p = controller.checkDuplicate();
            Test.stopTest();
            system.assert(controller.allowRenew == true);
        }
    }
    
    static testMethod void testDuplicateAllowRenew() {
        buildData();
        System.runAs(portalAccountOwner1) {
            Test.setCurrentPageReference(new PageReference('Page.Fon_JPDupMember'));
            System.currentPageReference().getParameters().put('id', sp.Id);
            
            List<OrderApi__Subscription__c> subs = [select id,OrderApi__Contact__c,OrderApi__Is_Active__c from OrderApi__Subscription__c where OrderApi__Contact__c =:con2.id AND OrderApi__Is_Active__c = true];
              
            Test.startTest();
            Fon_JPDupMemberCtrl controller = new Fon_JPDupMemberCtrl();   
            PageReference p = controller.checkDuplicate();
            Test.stopTest();
        }
    }
}