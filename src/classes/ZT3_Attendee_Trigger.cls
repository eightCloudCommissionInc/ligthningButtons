global  class ZT3_Attendee_Trigger extends Framework.Domain{  
    /**
* @author Sujitha Nandigam
*/
    public ZT3_Attendee_Trigger(List< EventApi__Attendee__c > sObjectList) {
        super(sObjectList);
    }
    
    global class Constructor implements Framework.Domain.DomainConstructor  {
        global Framework.Domain construct(List<SObject> sObjectList) {
            return new ZT3_Attendee_Trigger(sObjectList);
        }
    }
    
    public override void beforeUpdate(Map<Id,SObject> oldMap){
        Framework.Log.push(ZT3_Attendee_Trigger.class.getName(),'beforeUpdate'); 
        ZT3_Attendee_Extension.createRegistrantinGTWUpdate( (EventApi__Attendee__c []) records,(Map<Id,EventApi__Attendee__c>) oldMap);
        Framework.Log.pop();
    }
    
    public override void afterInsert(){
        Framework.Log.push(ZT3_Attendee_Trigger.class.getName(),'afterInsert');
        ZT3_Attendee_Extension.createRegistrantinGTW( (EventApi__Attendee__c []) records);
        Framework.Log.pop();
    }    
    
    
}