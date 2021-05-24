/**************************************************************************************************************************************************************************************************************************************************************
Name            :-  Fon_SalesOrderTrigger
Created Date    :-  03/22/2018
Updated Date  :-
Created By      :-  
Dependencies    :-
Description     :-  Trigger on salesorder to split billing street into 6 fields if charatcter count is more than 40. Bright key shipping limitation.
**************************************************************************************************************************************************************************************************************************************************************/
global class Fon_SalesOrderTrigger extends Framework.Domain{

    public Fon_SalesOrderTrigger(List<OrderApi__Sales_Order__c> sObjectList) {
        super(sObjectList);
    }

    global class Constructor implements Framework.Domain.DomainConstructor  {
        global Framework.Domain construct(List<SObject> sObjectList) {
            return new Fon_SalesOrderTrigger(sObjectList);
        }
    }
    public override void beforeInsert(){
        Framework.Log.push(Fon_SalesOrderTrigger.class.getName(),'beforeInsert');
        Fon_SalesOrderService.upsertStreetAddress( (OrderApi__Sales_Order__c []) records,null);        
        Framework.Log.pop();
    }

    public override void beforeUpdate(Map<Id,SObject> oldMap){
        Framework.Log.push(Fon_SalesOrderTrigger.class.getName(),'beforeUpdate');
        Fon_SalesOrderService.upsertStreetAddress( (OrderApi__Sales_Order__c []) records,(Map<Id,OrderApi__Sales_Order__c>) oldMap);    
        Framework.Log.pop();
    }
}