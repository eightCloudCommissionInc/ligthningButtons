global class GSA_JPMembershipCtrl extends PagesApi.DefaultTemplateController {
    global Contact UserContactData  { get; set; }
    public string userEmail;
    //public static string userEmailStatic;
    public static list<ResultSet> searchedRecord {get;set;} // wrapper solution
    public string searchedRecordId { get; set; }
  /*  
    static {
      userEmailStatic=  'test@asiacup.com';
    }
    */
    public GSA_JPMembershipCtrl() {
    if(Test.isRunningtest()){
        user u=[select id,name,email,contactId from User where id =: userinfo.getuserid()];
                this.UserContactData =[select id,name,email from Contact where id =: u.contactId];}
                else
         this.UserContactData = getCurrentContact();
         this.userEmail = UserContactData.Email; //UserContactData.Email;
        
        
        
    }
    
    public pagereference upateAccountOnContact(){
        boolean isUpdated = False;
        DomainMatcher DM = New DomainMatcher(userEmail);
        list<account> matchedAccounts = DM.matchedAccounts();
        if(matchedAccounts==NULL){
            //string accName=UserContactData.FirstName+UserContactData.LastName+'Individual';
            //Account newAcc = New Account(Name=accName);
            //insert newAcc; // giving invalid operation error, so writeen a trigger for the same
           // UserContactData.accountId = newAcc.Id; 
            isUpdated =true;
         }Else IF(matchedAccounts.size()==1){
            UserContactData.accountId = matchedAccounts[0].Id;
            isUpdated =true;
         }
         if(isUpdated){
         if(!test.isRunningtest())
             update UserContactData;
             system.debug('page action called');
             return nextStep();
         }
         return null;
    }
    
     @RemoteAction
      public static list<ResultSet> checkAccountsV2(string txtval){
        searchedRecord = new list<ResultSet>();
         DomainMatcher DM = New DomainMatcher(txtval);
        //DomainMatcher DM = New DomainMatcher(userEmailStatic);
        list<account> acc = DM.matchedAccounts();
        system.debug('account = ' + acc);
        if(acc!=Null && acc.size()>0){
            for(Account newAcc : acc){
                searchedRecord.add(new GSA_JPMembershipCtrl.ResultSet(newAcc.Id, newAcc.Name, newAcc.Company_Category__c, newAcc.ShippingCountry));
            }
        }
        return searchedRecord;
    }
    
   
    
    public pagereference save(){
        UserContactData.accountId = searchedRecordId;
        update UserContactData;
        system.debug('save button clicked');
        return nextStep();
      //return null;
    }
    
        
    
    
    
    public PageReference nextStep() {
        //save contact address
        try{
            String stepId = Framework.PageUtils.getParam('id');
            System.debug( 'stepId: '+stepId );
            
            joinApi.JoinUtils joinUtil = new joinApi.JoinUtils(stepId);
            String redirectURL = joinUtil.navStepsMap.get('Next');
            System.debug( 'redirectURL: '+redirectURL );
            JSONGenerator gen = JSON.createGenerator(true);
            gen.writeStartObject();
            gen.writeStringField('stepId', stepId);
            //system.debug('===UserContact '+UserContact);
            //add URL param to manage is it a new join process or renewal process
            PageReference pgRef = new PageReference(redirectURL);
            String isJoinStr = ApexPages.currentPage().getParameters().get('isJoin');
            system.debug( 'isJoinStr: '+isJoinStr );
            if( String.isNotBlank( isJoinStr ) ) {
                pgRef.getParameters().put( 'isJoin', isJoinStr );
            }

            gen.writeStringField('redirectURL', redirectURL);
            gen.writeEndObject();
            system.debug( 'gen genAsString'+gen.getAsString() );
            system.debug( 'joinUtil'+joinUtil );
            /*if(gen.getAsString()!=null)
                joinUtil.setRedirectURLCookie(gen.getAsString());*/           
            return pgRef;
            //return null;
        }
        catch(Exception e){
            system.debug('===exception'+e.getLineNumber()+e.getStackTraceString());
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.Error,e.getMessage()));
             return null;

        }
    }
  /*  
    public PageReference previousStep() {
        String stepId = Framework.PageUtils.getParam('id');
        joinApi.JoinUtils joinUtil = new joinApi.JoinUtils(stepId);
        //if(!Test.isRunningTest())
            return new PageReference(joinUtil.navStepsMap.get('Previous'));

        //return null;
    }
    
    public PageReference cancelStep() {
        String stepId = Framework.PageUtils.getParam('id');
        joinApi.JoinUtils joinUtil = new joinApi.JoinUtils(stepId);        
        joinUtil.deleteCookies();
        return new PageReference(joinUtil.navStepsMap.get('First'));
    }
    public GSA_JPMembershipCtrl(ApexPages.StandardController stdCon) {

    }
    
    public Boolean getIsPreviewMode() {
        return Framework.PageUtils.getBooleanParam('preview_mode');
    }

    public PageReference cancelPreview() {
        return new PageReference('/');
    }
    */
    public Contact getConObj() {
        return UserContactData;
    }


   
    
    global class ResultSet{
        public String Id {get;set;} 
        public String Name{get;set;}
        public String category{get;set;}
        public String country{get;set;}
        global ResultSet(String Id,String Name, string cat, string country){
            this.Id = Id;
            this.Name = Name; 
            if(cat==null){
                cat='';
            } 
            if(country==null){
                country='';
            }   
            this.category = cat; 
            this.country = country;      
        }
    }

}