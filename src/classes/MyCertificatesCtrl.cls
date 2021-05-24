public without sharing class MyCertificatesCtrl {

    @AuraEnabled
    public static List<Certification_and_CEU__c > getMyCEUs() {
        List<Certification_and_CEU__c> ceus;
        try {
            user u = [select id,contactid from user where id = : userinfo.getuserid()];
            System.debug('user'+u);
            if(u !=null){
                ceus = [SELECT Id,name, Contact__c, FON_Contact_Hours__c, FON_Item__r.name,FON_Awarded_Date__c ,FON_Number_of_Credits__c, Status__c FROM Certification_and_CEU__c where Contact__c =:u.contactid order by FON_Awarded_Date__c DESC];
                System.debug('ceus'+ceus );
            }
        }
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage()+e.getStackTraceString());
        }
          return ceus;   
    }

}