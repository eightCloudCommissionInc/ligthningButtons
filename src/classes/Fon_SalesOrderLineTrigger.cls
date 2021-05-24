/**************************************************************************************************************************************************************************************************************************************************************
Name            :-  Fon_SalesOrderLineTrigger
Created Date    :-  03/22/2018
Updated Date  :-
Created By      :-  
Dependencies    :-
Description     :-  Trigger on salesorder to split billing street into 6 fields if charatcter count is more than 40. Bright key shipping limitation.
**************************************************************************************************************************************************************************************************************************************************************/
global class Fon_SalesOrderLineTrigger extends Framework.Domain{

    public Fon_SalesOrderLineTrigger(List<OrderApi__Sales_Order_Line__c> sObjectList) {
        super(sObjectList);
    }

    global class Constructor implements Framework.Domain.DomainConstructor  {
        global Framework.Domain construct(List<SObject> sObjectList) {
            return new Fon_SalesOrderLineTrigger(sObjectList);
        }
    }
    public override void beforeInsert(){
        Framework.Log.push(Fon_SalesOrderLineTrigger.class.getName(),'beforeInsert');
        Fon_SalesOrderLineService.upsertStreetAddress( (OrderApi__Sales_Order_Line__c []) records,null);        
        Framework.Log.pop();
    }

    public override void beforeUpdate(Map<Id,SObject> oldMap){
        Framework.Log.push(Fon_SalesOrderLineTrigger.class.getName(),'beforeUpdate');
        Fon_SalesOrderLineService.upsertStreetAddress( (OrderApi__Sales_Order_Line__c []) records,(Map<Id,OrderApi__Sales_Order_Line__c>) oldMap);    
        Framework.Log.pop();
    }
}