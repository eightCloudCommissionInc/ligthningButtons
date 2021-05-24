/**************************************************************************************************************************************************************************************************************************************************************
Name            :-  Fon_RecepitLineTrigger
Created Date    :-  03/22/2018
Updated Date    :-
Created By      :-  Ankit Kumar Verma
Dependencies    :-
Description     :-  Trigger on Recepit Line to make callout to LMS whenever Recepit Line Records get created.
**************************************************************************************************************************************************************************************************************************************************************/


global class Fon_RecepitLineTrigger extends Framework.Domain{
    public Fon_RecepitLineTrigger(List<OrderApi__Receipt_Line__c> sObjectList) {
        super(sObjectList);
    }
    global class Constructor implements Framework.Domain.DomainConstructor  {
        global Framework.Domain construct(List<SObject> sObjectList) {
            return new Fon_RecepitLineTrigger(sObjectList);
        }
    }
    
    public override void afterInsert(){
        Framework.Log.push(Fon_RecepitLineTrigger.class.getName(),'afterInsert');
        Fon_ItemRegistration.onAfterInsert((OrderApi__Receipt_Line__c[]) records);
        Framework.Log.pop();
    }
}