/**************************************************************************************************************************************************************************************************************************************************************
Name            :-  Fon_CEUTrigger
Created Date    :-  03/22/2018
Updated Date  :-
Created By      :-  
Dependencies    :-
Description     :-  Trigger on Certification_and_CEU__c to send callout to Boomi whenever subscription record is created.
**************************************************************************************************************************************************************************************************************************************************************/


global class Fon_CEUTrigger extends Framework.Domain{
    public static Boolean recflag = true;
    public Fon_CEUTrigger(List<Certification_and_CEU__c> sObjectList) {
        super(sObjectList);
    }

    global class Constructor implements Framework.Domain.DomainConstructor  {
        global Framework.Domain construct(List<SObject> sObjectList) {
            return new Fon_CEUTrigger(sObjectList);
        }
    }

    public override void beforeInsert(){
        Framework.Log.push(Fon_CEUTrigger.class.getName(),'beforeInsert');
        
        Framework.Log.pop();
    }

    /*public override void beforeUpdate(Map<Id,SObject> oldMap){
        Framework.Log.push(Fon_CEUTrigger.class.getName(),'beforeUpdate');
        Framework.Log.pop();
    }


    public override void afterUpdate(Map<Id,SObject> oldMap) {
        Framework.Log.push(Fon_CEUTrigger.class.getName(),'afterUpdate');
       
        Framework.Log.pop();
    }*/

    public override void afterInsert(){
        Framework.Log.push(Fon_CEUTrigger.class.getName(),'afterInsert');
        
        Fon_CEUService.updateAttendeeCEU((Certification_and_CEU__c[])records,null);
        
        Framework.Log.pop();
    }
}