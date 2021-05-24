global class Fon_ConnectedAppPlugin extends Auth.ConnectedAppPlugin {
    
    // Authorize the app
    global override Boolean authorize(Id userId, Id connectedAppId, Boolean isAdminApproved, Auth.InvocationContext context) {   
        return isAdminApproved;
    }
    
    // Add custom info to the SAML Response    
    global override Map<String,String> customAttributes(Id userId, Id connectedAppId, Map<String,String> formulaDefinedAttributes, Auth.InvocationContext context) {  
        String contactId = '';
        String accountId = '';
        String member = 'false';
        String subscriber = 'false';
        Set<Id> accountIds = new Set<Id>();
        
        User usr = [SELECT Id, Name,ContactId, Contact.AccountId FROM User WHERE Id =: userId];
        
        if (usr.ContactId != null) {
            contactId = usr.ContactId;
        }
        if(usr.Contact.AccountId !=null){
            accountId = usr.Contact.AccountId;
            accountIds.add(usr.Contact.AccountId);
        }
        if (string.isBlank(contactId)) {
            return formulaDefinedAttributes;    
        }
        
        List<npe5__Affiliation__c> affList = [select id,npe5__Organization__c from npe5__Affiliation__c
                                             where npe5__Organization__c != null
                                             AND npe5__Contact__c =:contactId];
        if(affList.size()>0){
            for(npe5__Affiliation__c affObj : affList){
                accountIds.add(affObj.npe5__Organization__c);
            }  
        }
        
        list<OrderApi__Badge__c> badges = [
            SELECT OrderApi__Is_Active__c,
            OrderApi__Badge_Type__r.Type__c
            FROM OrderApi__Badge__c WHERE OrderApi__Is_Active__c = true
            AND OrderApi__Badge_Type__r.Type__c includes('Member','Subscriber') 
            AND (OrderApi__Contact__c =: contactId OR OrderApi__Account__c IN: accountIds)];
        
        Contact con = [SELECT Id,AccountId,Name,OrderApi__Badges__c,Email,Is_HealthySteps__c FROM Contact WHERE Id=:contactId];
        
        if(badges.size()>0){
            for(OrderApi__Badge__c record :  badges) {
                String type = record.OrderApi__Badge_Type__r.Type__c <> null ? record.OrderApi__Badge_Type__r.Type__c : 'null';
                if (type.contains('Member')) {
                    member = 'true';
                }
                if (type.contains('Subscriber')) {
                    subscriber = 'true';
                }
            }
        }
        
        formulaDefinedAttributes.put('email',con.Email);
        formulaDefinedAttributes.put('name',con.Name);
        formulaDefinedAttributes.put('accountId',con.Id);
        formulaDefinedAttributes.put('member',member);
        formulaDefinedAttributes.put('subscriber',subscriber);
        List<ConnectedApplication> conApp = new List<ConnectedApplication>([Select Id, Name From ConnectedApplication WHERE ID =:connectedAppId]);
        String appnames = Label.ThreeSpotApp;
        if (!conApp.isEmpty() && conApp[0].Name == appnames) {
            String healthySteps = (con.Is_HealthySteps__c) ? 'true' : 'false';
            formulaDefinedAttributes.put('healthySteps',healthySteps);
        }
        return formulaDefinedAttributes;    
    }    
}