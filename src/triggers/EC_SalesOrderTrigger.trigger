trigger EC_SalesOrderTrigger on OrderApi__Sales_Order__c (after delete,after update) {
    
    set<id> contactSet=new set<id>();
    
    if(trigger.isdelete){
        for(OrderApi__Sales_Order__c sol: trigger.Old){
            contactSet.add(sol.OrderApi__Contact__c );
        }
		EC_SalesOrderLineTriggerHandler.processData(contactSet);
    }
    if(trigger.isupdate){
        for(OrderApi__Sales_Order__c sol: trigger.new){
            if(sol.OrderApi__Posted_Date__c!=trigger.oldmap.get(sol.id).OrderApi__Posted_Date__c)contactSet.add(sol.OrderApi__Contact__c );
        }
		if(!contactSet.isEmpty())EC_SalesOrderLineTriggerHandler.processData(contactSet);
    }
        
}