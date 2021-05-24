/**************************************************************************************************************************************************************************************************************************************************************
Description     :-  Custom Controller for Join Process - Avoid duplicate memberships. 
**************************************************************************************************************************************************************************************************************************************************************/
public without sharing class Fon_JPDupMemberCtrl extends PagesApi.DefaultTemplateController {
    public List<OrderApi__Subscription__c> subs             { get; set; }
    public Contact UserContact { get; set; }
    public boolean allowRenew  { get; set; }
    public List< OrderApi__Assignment__c > subscriberManager             { get; set; }
    public PageReference checkDuplicate() {
        subs = new List<OrderApi__Subscription__c>();
        subscriberManager = new List< OrderApi__Assignment__c >();
        this.UserContact = getCurrentContact();
        if(this.UserContact != null){
            String stepId = Framework.PageUtils.getParam('id');
            subs = [select id,OrderApi__Current_Term_Start_Date__c,OrderApi__Contact__c,OrderApi__Is_Active__c,OrderApi__Item__r.OrderApi__Display_Name__c, OrderApi__Current_Term_End_Date__c from OrderApi__Subscription__c where OrderApi__Contact__c =:this.UserContact.id ];
            system.debug('~~~~~'+subs);
            system.debug('size'+subs.size());
            if(subs.size() < 1){  
                allowRenew = false;
            }
            else{
                allowRenew = true;
            }  
            if(allowRenew == false) {
                stepId = Framework.PageUtils.getParam('id');
                joinApi.JoinUtils joinUtil = new joinApi.JoinUtils(stepId);
                String redirectURL = joinUtil.navStepsMap.get('Next');
                JSONGenerator gen = JSON.createGenerator(true);
                gen.writeStartObject();
                gen.writeStringField('stepId', stepId);
                //system.debug('===UserContact '+UserContact);
                gen.writeStringField('redirectURL', redirectURL);
                gen.writeEndObject();
                try{
                    if(gen.getAsString()!=null)
                        joinUtil.setRedirectURLCookie(gen.getAsString());
                }catch(Exception e){system.debug('===='+e);}
                
                return new PageReference(redirectURL);
            }
        }
        return null;
    }
    
    public Fon_JPDupMemberCtrl() {
        subs = new List<OrderApi__Subscription__c>();
        allowRenew = false;
        this.UserContact = getCurrentContact();
        
    }
    
    public PageReference cancelStep() {
        PageReference p = new Pagereference('/cpbase__profile');      
        p.setredirect(true);
        return p;
    }
}