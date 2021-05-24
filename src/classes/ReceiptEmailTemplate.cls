Public class ReceiptEmailTemplate{

    @InvocableMethod
    public static void sendEmail(List<string> receipIds) {
        
        Map<Id,String> ReceiptToTemplate = new Map<Id,String>();
        Map<String,Id> TemplateNameToId = new Map<String,Id>();
        
        List<OrderApi__Receipt__c> listReceipt = [select id,Name,OrderApi__Contact__r.email,is_Generic__c,OrderApi__Contact__c from OrderApi__Receipt__c 
                                             where id=:receipIds];
        
        List<OrderApi__Receipt_Line__c> rllist = [select id,Name, Event_Template__c,OrderApi__Item__r.OrderApi__Is_Event__c,OrderApi__Receipt__c  from OrderApi__Receipt_Line__c 
                                             where OrderApi__Receipt__c=:receipIds and OrderApi__Item__r.OrderApi__Is_Event__c=true];
        
       
        for(OrderApi__Receipt_Line__c rl :rllist ){
            if(rl.Event_Template__c!=null)
                ReceiptToTemplate.put(rl.OrderApi__Receipt__c,rl.Event_Template__c);
        
        }
        
        for(OrderApi__Receipt__c rc : listReceipt ){
               if(ReceiptToTemplate.containsKey(rc.Id) && ReceiptToTemplate.get(rc.Id)!=null){
                 rc.is_Generic__c = false;      
               }                              
               else{
                 rc.is_Generic__c = true;   
               }
        }
        
        if(!listReceipt.isEmpty() ){
            update listReceipt; 
        }
        
        List<EmailTemplate> etList = [select id, name,developerName from EmailTemplate 
                                  where DeveloperName=:ReceiptToTemplate.values()];
        
        for(EmailTemplate em :etList){
            if(em.developerName!=null)
              TemplateNameToId.put(em.developerName,em.Id);
        }
        
        
      List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        
      
      for(OrderApi__Receipt__c rec : listReceipt )
      {
        
        if(rec.OrderApi__Contact__c!=null && rec.OrderApi__Contact__r.email!=null && TemplateNameToId.get(ReceiptToTemplate.get(rec.id))!=null){
            // Step 1: Create a new Email
            Messaging.SingleEmailMessage mail = 
            new Messaging.SingleEmailMessage();
            
            // Step 2: Set list of people who should get the email
            List<String> sendTo = new List<String>();
            sendTo.add(rec.OrderApi__Contact__r.email);
            mail.setToAddresses(sendTo);
            
            // Step 3: Set who the email is sent from
            //mail.setSenderDisplayName('Official Bank of Nigeria');
            
           
            mail.setTemplateID(TemplateNameToId.get(ReceiptToTemplate.get(rec.id)));
            mail.setSaveAsActivity(false);
            mail.setTargetObjectId(rec.OrderApi__Contact__c);
            mail.setwhatId(rec.Id);
            
            // Step 5. Add your email to the master list
            mails.add(mail);        
          }
      }
      Messaging.sendEmail(mails);
      
  }
    

}