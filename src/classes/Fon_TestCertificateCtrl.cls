@isTest
public with sharing class Fon_TestCertificateCtrl {
   static Boolean isInstalled = false;
    private static Contact con1 = new Contact();
    private static User portalAccountOwner;
    private static String timezone = 'America/Adak';
    static EventApi__Event_Category__c cat = new EventApi__Event_Category__c(); 
    static EventApi__Event__c ev = new EventApi__Event__c ();
    static EventApi__Ticket_Type__c tt = new EventApi__Ticket_Type__c();  
    static testMethod void testEventCancel() {    
        //Fon_TestUtil.BasicObjectCreation();  
        Fon_PackageScript.testInstall();
        Account acct = new Account();
        acct.Name = 'Test Account';
        insert acct;
        con1 = new Contact();
        con1.LastName = 'LASTNAME';
        con1.AccountId = acct.Id;
        con1.Email ='testemail@testemail.com';
        insert con1;
        cat.Name = 'Test Event Category';
        cat.EventApi__Description__c = 'Test Desc';
        insert cat;

        ev.EventApi__Event_Category__c = cat.Id;
        ev.Name = 'Test Event';
        ev.EventApi__Event_Key__c = 'ABCD';
        ev.EventApi__Start_Date_Time__c = Datetime.now().addDays(3);
        ev.EventApi__Attendees__c = 10;
        ev.EventApi__Capacity__c = 100;
        ev.EventApi__Enable_Access_Permissions__c = false;
        ev.EventApi__Enable_Registration_Groups__c = true;
        ev.EventApi__End_Date_Time__c = Datetime.now().addDays(7);
        ev.EventApi__Start_Time__c ='11:56';
        ev.EventApi__End_Time__c='04:59';
        ev.EventApi__Is_Active__c = true;
        ev.EventApi__Is_Published__c = true;
        ev.EventApi__Registration_Instructions__c = 'Test Instructions';
        ev.EventApi__Registration_Style__c = 'Lightning Event';
        ev.EventApi__Status__c = 'Active';
        ev.EventApi__Ticket_Sales_Start_Date__c = Date.today();
        ev.EventApi__Time_Zone__c = '(GMT-10:00) '+timezone;
        ev.Insight_Event_ID__c  ='T_2793';
        insert ev;
        system.debug('======='+ev);

        tt.EventApi__Event__c = ev.Id;
        tt.Name = 'Test Item Name';
        tt.EventApi__UOM__c = 'Ticket';
        tt.EventApi__Price__c = 100.00;
        tt.EventApi__Cost__c = 100.00;
        tt.EventApi__Description__c = 'Test Description';
        tt.EventApi__Display_Available_Inventory__c = true;
        tt.EventApi__Early_Bird_End_Date__c = Date.today();
        tt.EventApi__Early_Bird_Price__c = 100.00;
        tt.EventApi__Enable_Access_Permissions__c = true;
        tt.EventApi__Enable_Early_Bird_Price__c = true;
        tt.EventApi__Enable_Onsite_Price__c = true;
        tt.EventApi__Inventory_Status__c = 'In-Stock';
        tt.EventApi__Is_Active__c = true;
        tt.EventApi__Is_Published__c = true;
        tt.EventApi__Onsite_Price__c = 100.00;
        tt.EventApi__Price__c = 100.00;
        tt.EventApi__Quantity_Available__c = 100;
        tt.EventApi__Quantity_Sold__c = 100;
        insert tt;
        
                
        OrderApi__Business_Group__c BG1 =  new OrderApi__Business_Group__c();
        BG1.Name = 'BG1Name';
        insert BG1;       
        
        OrderApi__Item_Class__c itmc = new OrderApi__Item_Class__c();
        itmc.Name = 'Test Class Fee';
        itmc.OrderApi__Is_Active__c = true;
        itmc.OrderApi__Business_Group__c = BG1.Id;
        insert itmc;
        
        list<OrderApi__Item__c> items = new list<OrderApi__Item__c>();
        OrderApi__Item__c itm = new OrderApi__Item__c();
        itm.OrderApi__Price__c = 10;
        itm.OrderApi__Item_Class__c = itmc.Id;
        itm.Name = 'testfee';
        itm.OrderApi__Is_Event__c = true;
        itm.EventApi__Event__c = ev.id;
        itm.OrderApi__Business_Group__c = BG1.Id;
        insert itm;

        EventApi__Attendee__c attn = new EventApi__Attendee__c();
        attn.EventApi__Contact__c = con1.id;
        attn.EventApi__Attendee_Event__c = ev.id;
        attn.EventApi__Status__c= 'Registered';
        insert attn;

        EventApi__Registration_Item__c reg = new EventApi__Registration_Item__c();
        reg.EventApi__Item__c = itm.id;
        reg.EventApi__Attendee__c= attn.id;
        insert reg;
        Certification_and_CEU__c ceu = new Certification_and_CEU__c();
        ceu.Contact__c = con1.id;
        ceu.FON_Number_of_Credits__c = 2;
        ceu.FON_Item__c = itm.id;
        insert ceu;
        
        Test.startTest();
        
        

        MyCertificatesCtrl.getMyCEUs();
        Test.setCurrentPageReference(new PageReference('Page.ViewCertificate'));
        System.currentPageReference().getParameters().put('ceuid', ceu.Id);
        ViewCertificateCtrl ctr = new ViewCertificateCtrl();
      
        Test.stoptest();
        //list<OrderApi__Receipt__c> refundReceipts = [select id,name from OrderApi__Receipt__c];
        //system.assert(refundReceipts.size()>0);
        
        
        }
    }