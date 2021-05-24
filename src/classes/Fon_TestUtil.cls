public with sharing class Fon_TestUtil {
    
    static Boolean isInstalled = false;
    private static Contact con1 = new Contact();
    private static Account acct = new Account();
    private static User portalAccountOwner;
    public static void install() {
      // Fon_PackageScripts.testInstall();
        
    }

    public static User getPortalUser(){
        return portalAccountOwner;
    }
    public static Contact getContact(){
        return con1;
    }
    public static account getAccount(){
        return acct;
    }

  
     public static void contaccCreation(){
       Fon_PackageScript.testInstall();  
               joinApi.PackageScripts.install();
 
        map<id,profile>  adprofile= new map<id,Profile>([select id from profile where name ='System Administrator' limit 1]);
        user adminuser =[select id from user where IsActive =true AND UserRoleId!=null AND profileid IN :adprofile.Keyset() limit 1];  
        system.runAs(adminuser){
            acct = new Account();
            acct.Name = 'Test Account';
            insert acct;
            con1 = new Contact();
            con1.LastName = 'LASTNAME';
            con1.AccountId = acct.Id;
            con1.Email ='testemail@testemail.com';
            con1.OtherStreet = 'teststreet1 \n teststreet2 \n teststreet3';
            con1.MailingStreet = 'testmailingstreet1 \n testmailingstreet2 \n testmailingstreet3';
            insert con1; 
            
            OrderApi__AccountDomain__c accDomain = new OrderApi__AccountDomain__c();
            accDomain.OrderApi__Company__c = acct.Id;
            accDomain.OrderApi__Value__c = 'testemail.com';
            insert accDomain;
            
            OrderApi__AccountDomain__c accSubDomain = new OrderApi__AccountDomain__c();
            accSubDomain.OrderApi__Company__c = acct.Id;
            accSubDomain.OrderApi__Value__c = 'testemail.cup.com';
            insert accSubDomain;
        }
     }
    public static void BasicObjectCreation(){
        contaccCreation();
        OrderApi__Business_Group__c BG1 =  new OrderApi__Business_Group__c();
        BG1.Name = 'BG1Name';
        insert BG1;
        
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
       
        
    }
     
   
}