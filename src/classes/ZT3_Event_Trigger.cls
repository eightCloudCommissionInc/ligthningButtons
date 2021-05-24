global  class ZT3_Event_Trigger extends Framework.Domain{  
    /**
* @author Sujitha Nandigam
*/
    public static boolean updateRun = true; 
    
    public ZT3_Event_Trigger(List< EventApi__Event__c > sObjectList) {
        super(sObjectList);
    }
    
    global class Constructor implements Framework.Domain.DomainConstructor  {
        global Framework.Domain construct(List<SObject> sObjectList) {
            return new ZT3_Event_Trigger(sObjectList);
        }
    }
    
    /*public override void beforeInsert() {
Framework.Log.push(AAUM_ReceiptLine_Trigger.class.getName(),'beforeInsert'); 
AAUM_ReceipLine_Extension.CalculateTaxDeductible( (OrderApi__Receipt_Line__c []) records);
Framework.Log.pop();
}

public override void beforeUpdate(Map<Id,SObject> oldMap){
Framework.Log.push(AAUM_ReceiptLine_Trigger.class.getName(),'beforeUpdate'); 
AAUM_ReceipLine_Extension.CalculateTaxDeductible( (OrderApi__Receipt_Line__c []) records);
Framework.Log.pop();
}

public override void afterInsert(){
Framework.Log.push(ZT3_Attendee_Trigger.class.getName(),'afterInsert');
ZT3_Attendee_Extension.createRegistrantinGTW( (EventApi__Attendee__c []) records);
Framework.Log.pop();
} */  
    
    public override void afterUpdate(Map<Id,SObject> oldMap){
        Framework.Log.push(ZT3_Event_Trigger.class.getName(),'afterUpdate');
        System.debug(' AFTER UPDATE ');
        if(updateRun){
            ZT3_Event_Extension.attendeeSync( (EventApi__Event__c []) records);
            updateRun=false;
        }
        Framework.Log.pop();
    }
}