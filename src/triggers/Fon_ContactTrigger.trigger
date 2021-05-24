trigger Fon_ContactTrigger on Contact (before update, after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        Fon_ContactTriggerHelper.createAffiliation(Trigger.New, Trigger.oldMap);
        //Fon_ContactTriggerHelper.setupAffiliationByIntegrationUser( (List<Contact>)Trigger.New, (Map<Id, Contact>)Trigger.oldMap );
    }
  /*  if(Trigger.isBefore && Trigger.isUpdate){
        for(Contact con: Trigger.New){
            system.debug('oldId-->>'+Trigger.oldMap.get(con.Id).AccountId);
            system.debug('newId-->>'+con.AccountId);
            system.debug('old Badge--->>'+Trigger.oldMap.get(con.Id).OrderApi__Badges__c);
            system.debug('new Badge--->>'+con.OrderApi__Badges__c);
            if((Trigger.oldMap.get(con.Id).OrderApi__Badges__c!=null && Trigger.oldMap.get(con.Id).AccountId != con.AccountId) || ! Trigger.oldMap.get(con.Id).OrderApi__Badges__c.containsAny(con.OrderApi__Badges__c)){
                system.debug('Test123-->>');
                con.OrderApi__Badges__c  = Trigger.oldMap.get(con.Id).OrderApi__Badges__c;
            }
        }
    } */
}
/*
trigger Fon_ContactTrigger on Contact (before update, after update) {
    if(Trigger.isAfter && Trigger.isUpdate){
        //Fon_ContactTriggerHelper.createAffiliation(Trigger.New, Trigger.oldMap);
        Fon_ContactTriggerHelper.setupAffiliationByIntegrationUser( (List<Contact>)Trigger.New, (Map<Id, Contact>)Trigger.oldMap );
    }
    if(Trigger.isBefore && Trigger.isUpdate){
        for(Contact con: Trigger.New){
            if((Trigger.oldMap.get(con.Id).OrderApi__Badges__c!=null && Trigger.oldMap.get(con.Id).AccountId != con.AccountId) || ! Trigger.oldMap.get(con.Id).OrderApi__Badges__c.containsAny(con.OrderApi__Badges__c)){
                con.OrderApi__Badges__c  = Trigger.oldMap.get(con.Id).OrderApi__Badges__c;
            }
        }
    }
}*/