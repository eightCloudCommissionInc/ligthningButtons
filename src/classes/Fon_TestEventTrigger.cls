@isTest
public with sharing class Fon_TestEventTrigger {
   static Boolean isInstalled = false;
    private static Contact con1 = new Contact();
    private static User portalAccountOwner;
    private static String timezone = 'America/Adak';
    static EventApi__Event_Category__c cat = new EventApi__Event_Category__c(); 
    static EventApi__Event__c ev = new EventApi__Event__c();
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
                ev.Webinar_Key__c='1528026891685592587';

        insert ev;

        system.debug('======='+ev);
                Map<Id,String> attendMap =new Map<Id,String>();

         EventApi__Attendee__c attn = new EventApi__Attendee__c();
        attn.EventApi__Contact__c = con1.id;
        attn.EventApi__Attendee_Event__c= ev.id;
        attn.EventApi__Status__c= 'Registered';
                                insert attn;

        attendMap.put(attn.id,attn.Event_Webinar_Key__c);
        
                Test.StartTest();
                          Attendeedata a = new Attendeedata();

        ev.Session_Key__c='15995390';
                    update ev;

        Map<String,String> keys = new Map<String,String>();
        keys.put(ev.Webinar_Key__c, ev.Session_Key__c);
        
                Test.setMock(HttpCalloutMock.class, new ExampleCalloutMock());

        ZT3_Attendee_Extension.asynchCallout(attendMap.values(),attendMap.keySet());      

        
                ZT3_Event_Extension.asynchCallout(keys,attendMap.keySet());    

        Test.StopTest();
        
        }}