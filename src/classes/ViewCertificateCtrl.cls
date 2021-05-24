/**************************************************************************************************************************************************************************************************************************************************************
Name            :-  ViewCertificateCtrl
Created Date    :-  4/09/2019
Updated Date    :-  
Created By      :-  Arpita Munjal
Updated By      :-  
Dependencies    :-  
Description     :-  Custom Controller for ceu certificate page, displays ceu info as printable version.
**************************************************************************************************************************************************************************************************************************************************************/


public class ViewCertificateCtrl {
    
    public list<Certification_and_CEU__c> ceus                   { get; set; }
     //public Membership_Certificate_Management__mdt configCert     { get; set; }

    private Id fetchSubscriptionId(){
        Id certificateId;
        try {
            
            certificateId = Framework.PageUtils.getParam('ceuid'); 
           
        } catch (Exception e) {
            certificateId = null;
        }
        
        return certificateId;
    }

   
    //CONSTRUCTOR
    public ViewCertificateCtrl(){
        
        ceus = new  list<Certification_and_CEU__c>();
       // site = [SELECT Id, OrderApi__Business_Group__r.Membership_Cert_Signature_URL__c, OrderApi__Business_Group__r.Membership_Certificate_Info__c, OrderApi__Business_Group__r.AOCMF_Logo_URL__c, PagesApi__Theme__r.PagesApi__Logo_Image__c FROM PagesApi__Site__c WHERE Id = : siteId];
        User u = [SELECT Id, AccountId, ContactId FROM User WHERE Id = : UserInfo.getUserId() LIMIT 1];
        if(fetchSubscriptionId() !=null)
            ceus = [select id, FON_Awarded_Date__c,name, Contact__r.name, FON_Contact_Hours__c, FON_Item__r.name, FON_Number_of_Credits__c from Certification_and_CEU__c where id=:fetchSubscriptionId()];
       
    
    }
}