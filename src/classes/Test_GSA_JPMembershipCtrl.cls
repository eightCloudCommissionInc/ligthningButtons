@IsTest
private class Test_GSA_JPMembershipCtrl {
    
    static joinapi__Join_Process__c jp = new joinapi__Join_Process__c();
    static joinapi__Step__c sp = new joinapi__Step__c();
    private static Contact con1 = new Contact();
    private static User portalAccountOwner;

    static void buildData() {
        Fon_TestUtil.BasicObjectCreation();
         jp.joinapi__Join_Process_Display_Name__c = 'Test';
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
        
        sp.joinapi__Visual_Force_Page_API_Name__c = 'MatchEmailDomain';
        insert sp;
        
        joinapi__Step__c sp2 = new joinapi__Step__c();
        sp2.joinapi__Join_Process__c = jp.Id;
        sp2.joinapi__Next_Step__c = sp.Id;
        sp2.joinapi__Is_First_Step__c = TRUE;
        insert sp2;
        
    }
    
    static testMethod void testMainDomain() {
        buildData();
        portalAccountOwner = Fon_TestUtil.getPortalUser();
        con1 = Fon_TestUtil.getContact();
        Account myAcc = Fon_TestUtil.getAccount();
        System.runAs(portalAccountOwner) {
            Test.setCurrentPageReference(new PageReference('Page.MatchEmailDomain'));
            System.currentPageReference().getParameters().put('id', sp.Id);
            GSA_JPMembershipCtrl controller = new GSA_JPMembershipCtrl();
            
            Test.startTest();
                controller.UserContactData = con1;
                controller.upateAccountOnContact();
                GSA_JPMembershipCtrl.checkAccountsV2('testemail@testemail.com');
                 for(Account newAcc : [Select ID,Name, Company_Category__c,ShippingCountry From Account where Id =:myAcc.Id]){
                   GSA_JPMembershipCtrl.ResultSet rs = new GSA_JPMembershipCtrl.ResultSet(newAcc.Id, newAcc.Name, newAcc.Company_Category__c, newAcc.ShippingCountry);
                   
                }
                controller.getConObj();
                
            Test.stopTest();
        
        }
    }
    
    static testMethod void testSubDomain() {
        buildData();
        portalAccountOwner = Fon_TestUtil.getPortalUser();
        con1 = Fon_TestUtil.getContact();
        Account myAcc = Fon_TestUtil.getAccount();
        System.runAs(portalAccountOwner) {
            Test.setCurrentPageReference(new PageReference('Page.MatchEmailDomain'));
            System.currentPageReference().getParameters().put('id', sp.Id);
            GSA_JPMembershipCtrl controller = new GSA_JPMembershipCtrl();
            
            Test.startTest();
                
                GSA_JPMembershipCtrl.checkAccountsV2('testemail@testemail.cup.com');
                                controller.save();

                
            Test.stopTest();
        
        }
    }

}