trigger EC_SalesOrderLineTrigger on OrderApi__Sales_Order_Line__c (after insert,after update,after delete) {
    
    
    if(trigger.isinsert || trigger.isupdate){
        EC_SalesOrderLineTriggerHandler.after(trigger.New);
    }
    
    if(trigger.isdelete){
        EC_SalesOrderLineTriggerHandler.after(trigger.old);
    }
    
    
    
    
}