public class SubscriptionTgrCls {
   
    public static void SubscriptionContactIsMemberUpdate(List<OrderApi__Subscription__c> newSubscriptionList, Boolean isInsert, Map<Id,OrderApi__Subscription__c> oldSubscriptionMap, Boolean IsUpdate) {
       
       
        List<OrderApi__Subscription__c> subscriptionList = new List<OrderApi__Subscription__c>();
        Set<Id> contactList = new Set<Id>();
        Set<Id> subscriptionIdSet = new Set<Id>();
        Map<Id,contact> conUpdate = new Map<Id,contact>();
        
       
        for(OrderApi__Subscription__c subs : newSubscriptionList){
            subscriptionIdSet.add(subs.Id);
        }
        
        List<OrderApi__Subscription__c> test = [select id, name from OrderApi__Subscription__c where id=:subscriptionIdSet];
        system.debug('aaaaaaaa'+test);
        
        
        if ( isInsert ) {
            //subscriptionList = newSubscriptionList;
            for(OrderApi__Subscription__c subs : newSubscriptionList){
                contactList.add(subs.OrderApi__Contact__c);
            }
           
        }
        else if( IsUpdate ) {
            for(OrderApi__Subscription__c subs : [Select Id,OrderApi__Status__c,OrderApi__Contact__c,OrderApi__Contact__r.Is_Member__c,OrderApi__Item__r.Name,
                                                    OrderApi__Activated_Date__c,OrderApi__Paid_Through_Date__c,
                                                    OrderApi__Contact__r.FON_Membership_End_Date__c
                                                    FROM OrderApi__Subscription__c WHERE Id in: subscriptionIdSet ] ){
                if( (subs.OrderApi__Status__c != oldSubscriptionMap.get(subs.Id).OrderApi__Status__c ||
                   subs.OrderApi__Paid_Through_Date__c != oldSubscriptionMap.get(subs.Id).OrderApi__Paid_Through_Date__c )
                   && subs.OrderApi__Item__r.Name.contains('Membership')){
                    
                        //subscriptionList.add(subs);
                        contactList.add(subs.OrderApi__Contact__c);
                }
            }
        }
        
      
        List<Contact> updateContactList = new List<Contact>();
        for( Contact con: [Select id, name, (Select Id,OrderApi__Contact__c,OrderApi__Contact__r.Is_Member__c,OrderApi__Item__r.Name,
                                                    OrderApi__Activated_Date__c,OrderApi__Paid_Through_Date__c,OrderApi__Status__c,
                                                    OrderApi__Contact__r.FON_Membership_End_Date__c
                                                    FROM OrderApi__Subscriptions__r WHERE  OrderApi__Item__r.Name like '%Membership%' AND (OrderApi__Status__c = 'Active' OR OrderApi__Status__c = 'Pending') order by OrderApi__Paid_Through_Date__c desc limit 1) 
            
                                                   From Contact where id =: contactList] ){
            if(con.OrderApi__Subscriptions__r.size()>0){ 
                for(OrderApi__Subscription__c subs  : con.OrderApi__Subscriptions__r){                                       
                
                    //New membership
                    if ((subs.OrderApi__Status__c == 'Active' || subs.OrderApi__Status__c == 'Pending') &&
                        subs.OrderApi__Item__r.Name.contains('Membership') && subs.OrderApi__Activated_Date__c != NULL &&
                        subs.OrderApi__Paid_Through_Date__c != NULL
                    )
                    {
                        conUpdate.put(subs.OrderApi__Contact__c,new Contact(Id = subs.OrderApi__Contact__c,FON_Membership_End_Date__c = subs.OrderApi__Paid_Through_Date__c,
                                                   FON_Membership_Start_Date__c = subs.OrderApi__Activated_Date__c, Is_Member__c = True ));
                    }
                   
                    //Expired membership
                   else if ( subs.OrderApi__Status__c == 'Expired' || subs.OrderApi__Status__c == 'Cancelled' ||
                        subs.OrderApi__Status__c == 'Suspended'
                    )
                    {
                        conUpdate.put(subs.OrderApi__Contact__c,new Contact( Id = subs.OrderApi__Contact__c, Is_Member__c = false ));
                    }
                }
            }
            else{
                 conUpdate.put(con.id,new Contact( Id = con.id, Is_Member__c = false ));
            }
        }
        system.debug('aaaaaaaaa'+conUpdate);
        if(!conUpdate.isEmpty()){
            update conUpdate.values();
        }
    }

}