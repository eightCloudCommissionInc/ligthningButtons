trigger SubscriptionIsMemberUpdateTrigger on OrderApi__Subscription__c (after insert, After update) {
    if(Trigger.isInsert)
        SubscriptionTgrCls.SubscriptionContactIsMemberUpdate( Trigger.new, true,null,false);
    else if(Trigger.isUpdate)
        SubscriptionTgrCls.SubscriptionContactIsMemberUpdate( Trigger.new, false,trigger.oldmap,true);
}