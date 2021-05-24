/**************************************************************************************************************************************************************************************************************************************************************
Name            :-  Fon_PackageScripts
Created Date    :-  03/22/2018
Updated Date    :-  
Created By      :-  Arpita Munjal
Dependencies    :-  
Description     :-  Spark Admin and test class
**************************************************************************************************************************************************************************************************************************************************************/

global class Fon_PackageScript {

    global class Register implements Framework.Scriptable {
    global void run() {

        Framework.RegisteredApp ZT3App = new Framework.RegisteredApp();
        ZT3App.apexNamespace = '';
        ZT3App.namespace = 'ZT3';
        ZT3App.installClass = Fon_PackageScript.Install.class.getName();
        ZT3App.isManaged = false;
        ZT3App.isEnabled = true;
        ZT3App.isPaid = false;
        ZT3App.developerEmail = 'implementations@fonteva.com';
        ZT3App.owner = 'ZT3';
        ZT3App.description = 'Customizations built by Fonteva to support the implementation of MemberNation for ZT3.';
        ZT3App.Name = 'ZT3 Customizations';
        Framework.Config.push(ZT3App);


        //Register Objects
        Framework.RegisteredObject[] regObjects = new List<Framework.RegisteredObject>();
        Framework.RegisteredObject memstaging = new Framework.RegisteredObject();
        memstaging.sObjectName = Framework.SchemaService.getDescribe(Certification_and_CEU__c.SObjectType).getName();
        memstaging.apexClass = Fon_CEUTrigger.class.getName();
        memstaging.namespace = 'ZT3';
        memstaging.isEnabled = true;
        memstaging.isStandard = false;
        memstaging.triggersEnabled = true;
        memstaging.soqlLimit = String.valueOf(2000);
        memstaging.soqlOrderBy = SObjectType.Certification_and_CEU__c.fields.Name.getName() + ' ASC';
        Framework.Config.push(memstaging);
        // Routing Rules --- Alphabetically --- 
        Framework.RoutingRule[] rules = new List<Framework.RoutingRule>();
       
        Framework.RoutingRule sub2 = new Framework.RoutingRule();
        sub2.apexClass = Fon_CEUTrigger.class.getName();
        sub2.namespace = 'ZT3';
        sub2.isEnabled = true;
        sub2.sObjectName = 'Certification_and_CEU__c';
        sub2.executionOrder = 1;
        rules.add(sub2);
        
        Framework.RoutingRule sorder = new Framework.RoutingRule();
        sorder.apexClass = Fon_SalesOrderTrigger.class.getName();
        sorder.namespace = 'ZT3';
        sorder.isEnabled = true;
        sorder.sObjectName = 'OrderApi__Sales_Order__c';
        sorder.executionOrder = 1;
        rules.add(sorder);
        Framework.RoutingRule sub21 = new Framework.RoutingRule();
        sub21.apexClass = Fon_SalesOrderLineTrigger.class.getName();
        sub21.isEnabled = true;
        sub21.sObjectName = 'OrderApi__Sales_Order_Line__c';
        sub21.executionOrder = 1;
        rules.add(sub21);
         // For event
       Framework.RoutingRule recLine = new Framework.RoutingRule();
        recLine.apexClass = ZT3_Event_Trigger.class.getName();
        //recLine.namespace = 'AAUM';
        recLine.isEnabled = true;
        recLine.sObjectName = SObjectType.EventApi__Event__c.getName();
        recLine.executionOrder = 0;
        rules.add(recLine);
        
        
          // For event
       Framework.RoutingRule att = new Framework.RoutingRule();
        att.apexClass = ZT3_Attendee_Trigger.class.getName();
        //recLine.namespace = 'AAUM';
        att.isEnabled = true;
        att.sObjectName = SObjectType.EventApi__Attendee__c.getName();
        att.executionOrder = 0;
        rules.add(att);
        /*Framework.RoutingRule sub1 = new Framework.RoutingRule();
        sub1.apexClass = Fon_SubscriptionTrigger.class.getName();
        sub1.namespace = 'ZT3';
        sub1.isEnabled = true;
        sub1.sObjectName = 'OrderApi__Subscription__c';
        sub1.executionOrder = 1;
        rules.add(sub1);*/
        Framework.Config.push(rules);
    }

    }


    public static void testInstall() {
        Framework.Installer.install();
        PagesApi.PackageScripts.install();
        OrderApi.PackageScripts.install();
        EventApi.PackageScripts.install();
        CPBase.PackageScripts.install();
        ROEApi.PackageScripts.install();
        LTE.PackageScripts.install();
        new Fon_PackageScript.Install().run();
    }
    global class Install implements Framework.Scriptable {
        global void run() {
            Framework.Log.push(Fon_PackageScript.Install.class.getName(),'run');
            try {
                new Register().run();
                
            } catch (Exception ex) {
                Framework.Log.debugException(ex);
            }
            Framework.Log.pop();
        }
    }
   

}