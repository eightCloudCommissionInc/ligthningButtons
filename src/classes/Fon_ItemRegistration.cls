public class Fon_ItemRegistration {
    
    public static void onAfterInsert(List<OrderApi__Receipt_Line__c> receiptLineList){
        Set<Id> receiptLineIds = new Set<Id>();
        Set<Id> conIdsSet = new Set<Id>();
        String jsonstring;
        Id recepitId;
        
        List<OrderApi__Receipt_Line__c> recepitLineLst = new List<OrderApi__Receipt_Line__c>();
        for(OrderApi__Receipt_Line__c receiptline: receiptLineList){
            if(receiptline.Id != null){
                receiptLineIds.add(receiptline.Id);
                recepitId = receiptline.OrderApi__Receipt__c;
            }
        }
        System.debug('receiptLineIds..'+receiptLineIds);
        recepitLineLst = [Select id,OrderApi__Item__r.EventApi__Event__r.EventApi__Display_Name__c,OrderApi__Item__r.EventApi__Event__r.Event_Type__c,OrderApi__Receipt__r.OrderApi__Contact__c,OrderApi__Receipt__r.OrderApi__Contact__r.FirstName,OrderApi__Receipt__r.OrderApi__Contact__r.LastName,OrderApi__Receipt__r.OrderApi__Contact__r.Email,OrderApi__Item__c,OrderApi__Item__r.OrderApi__Item_Class__r.Name,OrderApi__Total__c from OrderApi__Receipt_Line__c where Id In:receiptLineIds];
        
        System.debug('recepitLineLst..'+recepitLineLst);
        
        String jsonListString = json.serialize(recepitLineLst);
        
        
        System.debug('jsonListString..'+jsonListString);
        if(jsonListString != '{}'){
            sendRegistrationItemsDetails(jsonListString,recepitId);
        }
    }
    
    
    @future (callout=true)
    public static void sendRegistrationItemsDetails(String jsonListString,Id recepitId){
        
        List<OrderApi__Receipt_Line__c> recepitLineLst = (List<OrderApi__Receipt_Line__c>)Json.deserialize(jsonListString,List<OrderApi__Receipt_Line__c>.class);
        List<Fon_ItemRegistrationWrapper> receiptLineWrappList = new List<Fon_ItemRegistrationWrapper>();
        
        for(OrderApi__Receipt_Line__c receiptline: recepitLineLst){
            
            Fon_ItemRegistrationWrapper receiptLineWrapp = new Fon_ItemRegistrationWrapper();
            if(receiptline.OrderApi__Item__r.OrderApi__Item_Class__r.Name == 'LMS Courses'){
                receiptLineWrapp.api_key = System.Label.LMS_Api_Key;
                receiptLineWrapp.remote_user_id = receiptline.OrderApi__Receipt__r.OrderApi__Contact__c;
                receiptLineWrapp.firstname = receiptline.OrderApi__Receipt__r.OrderApi__Contact__r.FirstName;
                receiptLineWrapp.lastname = receiptline.OrderApi__Receipt__r.OrderApi__Contact__r.LastName;
                receiptLineWrapp.email = receiptline.OrderApi__Receipt__r.OrderApi__Contact__r.Email;
                receiptLineWrapp.remote_product_id = receiptline.OrderApi__Item__c;
                receiptLineWrapp.amount_paid = receiptline.OrderApi__Total__c;
                receiptLineWrapp.send_email = true;
                receiptLineWrappList.add(receiptLineWrapp);
            }
            else if(receiptline.OrderApi__Item__r.EventApi__Event__r.Event_Type__c == 'Training Event'){
                receiptLineWrapp.api_key = System.Label.LMS_Api_Key;
                receiptLineWrapp.remote_user_id = receiptline.OrderApi__Receipt__r.OrderApi__Contact__c;
                receiptLineWrapp.firstname = receiptline.OrderApi__Receipt__r.OrderApi__Contact__r.FirstName;
                receiptLineWrapp.lastname = receiptline.OrderApi__Receipt__r.OrderApi__Contact__r.LastName;
                receiptLineWrapp.email = receiptline.OrderApi__Receipt__r.OrderApi__Contact__r.Email;
                receiptLineWrapp.remote_product_id = receiptline.OrderApi__Item__c;
                receiptLineWrapp.amount_paid = receiptline.OrderApi__Total__c;
                receiptLineWrapp.send_email = true;
                receiptLineWrappList.add(receiptLineWrapp);
            }
        }
        
        List<OrderApi__Receipt__c> recepitList = new List<OrderApi__Receipt__c>();
        
        for (Fon_ItemRegistrationWrapper receiptLineWrapp : receiptLineWrappList) {
            OrderApi__Receipt__c recUpdate = new OrderApi__Receipt__c();
            String jsonstring = json.serialize(receiptLineWrapp);
            System.debug('jsonstring..'+jsonstring);
            String dataEndPoint = System.Label.LMS_End_Point;
            System.debug('dataEndPoint..'+dataEndPoint);
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndPoint(dataEndPoint);
            req.setMethod('POST');
            req.setHeader('Content-Type','application/json');
            req.setBody(jsonstring);
            
            HttpResponse response = new HttpResponse();
            response = http.send(req);
            System.debug('response....'+response);
            if (response.getstatusCode() == 200 && response.getbody() != null){
                System.debug('response.getstatusCode()..'+response.getstatusCode());
                Fon_ItemRegistrationResponseWrapper responseWrapper = Fon_ItemRegistrationResponseWrapper.parse(response.getbody());
                System.debug('responseWrapper....'+responseWrapper);
                System.debug('responseWrapper.product_url....'+responseWrapper.product_url);
                recUpdate.Id = recepitId;
                // recUpdate.product_url__c = responseWrapper.product_url;
                recUpdate.product_url__c = 'https://zttlms.zerotothree.org/my-dashboard';
                
            }
            else if(response.getstatusCode() == 422 && response.getbody() != null){
                Fon_ItemRegistrationResponseWrapper responseWrapper = Fon_ItemRegistrationResponseWrapper.parse(response.getbody());
                SYstem.debug(',,,,'+responseWrapper.error_messages.product_url);
               
                recUpdate.Id = recepitId;
                //recUpdate.product_url__c = responseWrapper.error_messages.product_url;
                recUpdate.product_url__c = 'https://zttlms.zerotothree.org/my-dashboard';
                
                
                System.debug('nnn...');
            }
            recepitList.add(recUpdate);
            
        }
		 try{           
            if(!recepitList.isEmpty()){
            Database.update(recepitList);
        } 
        }catch(exception e){
            
        }
        
    }
}