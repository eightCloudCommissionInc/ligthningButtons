global class Subscription_Trigger extends Framework.Domain{
    public Subscription_Trigger(List<OrderApi__Subscription__c> sObjectList){
        super(sObjectList);
    }
    global class Constructor implements Framework.Domain.DomainConstructor  {
        global Framework.Domain construct(List<SObject> sObjectList) {
            return new Subscription_Trigger(sObjectList);
        }
    }
    
    public override void afterInsert() {
        system.debug('aaaa');
        Framework.Log.push(Subscription_Trigger.class.getName(),'afterInsert');
        Map<Id,OrderApi__Subscription__c> oldMap = new Map<Id,OrderApi__Subscription__c>();
        SubscriptionTgrCls.SubscriptionContactIsMemberUpdate( (OrderApi__Subscription__c []) records, true,null,false);
        Framework.Log.pop();
    }
    
    public override void afterUpdate(Map<Id,SObject> oldMap) {
        system.debug('bbbbbb');
        Framework.Log.push(Subscription_Trigger.class.getName(),'afterUpdate');
        Map<Id, OrderApi__Subscription__c> oldSubscriptionMap = (Map<Id, OrderApi__Subscription__c>) oldMap;  
        SubscriptionTgrCls.SubscriptionContactIsMemberUpdate( (OrderApi__Subscription__c []) records, false,oldSubscriptionMap,true);
        Framework.Log.pop();
    }
}