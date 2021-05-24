//included for ZTT-13
@isTest
private without sharing class FS_UpdateChatterGroupMemberBatchTest {
    @isTest private static void batchTest(){
        OrderApi__Business_Group__c businessGroup = new OrderApi__Business_Group__c();
        businessGroup.Name = 'test business group';
        insert businessGroup;

        Account acc = new Account();
        acc.Name = 'Test account';
        acc.Type = 'Member';
        acc.OrderApi__Account_Email__c = 'testAccount@gmail.com';
        insert acc;

        Contact con1 = new Contact();
        con1.LastName = 'Testcontact';
        con1.AccountId = acc.Id;
        con1.email = 'test@gmail.com';
        //con1.OrderApi__Is_Primary_Contact__c = true;
        insert con1;

        Account a = [SELECT Id, OrderApi__Primary_Contact__c FROM Account WHERE Id =: acc.Id];
        a.OrderApi__Primary_Contact__c = con1.Id;
        update a;

        Id profileId = [SELECT Id, Name FROM Profile WHERE Name LIKE 'Fonteva%Customer%Community%User' LIMIT 1][0].Id;

        User communityUser = new User();
        communityUser.Alias = 'test123';
        communityUser.Email = 'test123@gmail.com';
        communityUser.EmailEncodingKey = 'UTF-8';
        communityUser.LastName = 'Testing';
        communityUser.LanguageLocaleKey = 'en_US';
        communityUser.LocaleSidKey = 'en_US';
        communityUser.ProfileId = profileId;
        communityUser.Country = 'United States';
        communityUser.IsActive = true;
        communityUser.ContactId = con1.Id;
        communityUser.TimeZoneSidKey = 'America/Los_Angeles';
        communityUser.Username = 'tester@noemail.com';
        insert communityUser;

        PagesApi__Community_Group__c communityGroup = new PagesApi__Community_Group__c();
        communityGroup.Name = 'test';
        communityGroup.PagesApi__Type__c = 'Section';
        insert communityGroup;

        PagesApi__Community_Group__c cgr = [SELECT Id, PagesApi__Chatter_Group_Id__c, PagesApi__Community_Network_ID__c FROM
                PagesApi__Community_Group__c WHERE Id =: communityGroup.Id];
        System.debug('///'+'network id'+cgr.PagesApi__Community_Network_ID__c);

        CollaborationGroup collGrp = new CollaborationGroup();
        ConnectApi.ChatterGroupInput groupInput = new ConnectApi.ChatterGroupInput();
        groupInput.name = 'test chatter group';
        groupInput.visibility = ConnectApi.GroupVisibilityType.PublicAccess;

        List<PagesApi__Community_Group_Member__c> cgmListTest = new List<PagesApi__Community_Group_Member__c>();
        for(Integer i = 0;i<200;i++){
            PagesApi__Community_Group_Member__c communityGroupMember = new PagesApi__Community_Group_Member__c();
            communityGroupMember.PagesApi__Contact__c = con1.Id;
            communityGroupMember.PagesApi__Is_Active__c = true;
            communityGroupMember.PagesApi__Status__c = 'Deactivated';
            communityGroupMember.PagesApi__Community_Group__c = communityGroup.Id;
            cgmListTest.add(communityGroupMember);
        }
        try{
            insert cgmListTest;
        }catch(Exception e){
            System.debug(e.getMessage());
        }

        Test.startTest();
        FS_UpdateChatterGroupMemberBatchClass obj = new FS_UpdateChatterGroupMemberBatchClass();
        Database.executeBatch(obj);
        Test.stopTest();
    }
    @isTest static void schedulerTest()
    {
        String CRON_EXP = '0 0 0 15 3 ? *';
        OrderApi__Business_Group__c businessGroup = new OrderApi__Business_Group__c();
        businessGroup.Name = 'test business group';
        insert businessGroup;

        Account acc = new Account();
        acc.Name = 'Test account';
        acc.Type = 'Member';
        acc.OrderApi__Account_Email__c = 'testAccount@gmail.com';
        insert acc;

        Contact con1 = new Contact();
        con1.LastName = 'Testcontact';
        con1.AccountId = acc.Id;
        con1.email = 'test@gmail.com';
        //con1.OrderApi__Is_Primary_Contact__c = true;
        insert con1;

        Account a = [SELECT Id, OrderApi__Primary_Contact__c FROM Account WHERE Id =: acc.Id];
        a.OrderApi__Primary_Contact__c = con1.Id;
        update a;

        Id profileId = [SELECT Id, Name FROM Profile WHERE Name LIKE 'Fonteva%Customer%Community%User' LIMIT 1][0].Id;

        User communityUser = new User();
        communityUser.Alias = 'test123';
        communityUser.Email = 'test123@gmail.com';
        communityUser.EmailEncodingKey = 'UTF-8';
        communityUser.LastName = 'Testing';
        communityUser.LanguageLocaleKey = 'en_US';
        communityUser.LocaleSidKey = 'en_US';
        communityUser.ProfileId = profileId;
        communityUser.Country = 'United States';
        communityUser.IsActive = true;
        communityUser.ContactId = con1.Id;
        communityUser.TimeZoneSidKey = 'America/Los_Angeles';
        communityUser.Username = 'tester@noemail.com';
        insert communityUser;

        PagesApi__Community_Group__c communityGroup = new PagesApi__Community_Group__c();
        communityGroup.Name = 'test';
        communityGroup.PagesApi__Type__c = 'Section';
        insert communityGroup;

        PagesApi__Community_Group__c cgr = [SELECT Id, PagesApi__Chatter_Group_Id__c, PagesApi__Community_Network_ID__c FROM
                PagesApi__Community_Group__c WHERE Id =: communityGroup.Id];
        System.debug('///'+'network id'+cgr.PagesApi__Community_Network_ID__c);

        CollaborationGroup collGrp = new CollaborationGroup();
        ConnectApi.ChatterGroupInput groupInput = new ConnectApi.ChatterGroupInput();
        groupInput.name = 'test chatter group';
        groupInput.visibility = ConnectApi.GroupVisibilityType.PublicAccess;


        List<PagesApi__Community_Group_Member__c> cgmListTest = new List<PagesApi__Community_Group_Member__c>();
        for(Integer i = 0;i<200;i++){
            PagesApi__Community_Group_Member__c communityGroupMember = new PagesApi__Community_Group_Member__c();
            communityGroupMember.PagesApi__Contact__c = con1.Id;
            communityGroupMember.PagesApi__Is_Active__c = true;
            communityGroupMember.PagesApi__Status__c = 'Active';
            communityGroupMember.PagesApi__Community_Group__c = communityGroup.Id;
            cgmListTest.add(communityGroupMember);
        }
        try{
            insert cgmListTest;
        }catch(Exception e){
            System.debug(e.getMessage());
        }

        Test.startTest();

        String jobId = System.schedule('ScheduleApexClassTest',  CRON_EXP, new FS_UpdateChatterGroupMemberBatchClass());
        CronTrigger ct = [SELECT Id, CronExpression, TimesTriggered, NextFireTime FROM CronTrigger WHERE id = :jobId];
        System.assertEquals(CRON_EXP, ct.CronExpression);
        System.assertEquals(0, ct.TimesTriggered);

        Test.stopTest();
    }
}