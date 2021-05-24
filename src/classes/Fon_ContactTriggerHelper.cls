public class Fon_ContactTriggerHelper {
public static void createAffiliation(List<Contact> newList, Map<Id,Contact> oldMap){
    Set<Id> accountIds = new Set<Id>();
    Set<Id> existingAccountIds = new Set<Id>();
    Set<Id> contactIds = new Set<Id>();
    List<npe5__Affiliation__c> insertAffiliation = new  List<npe5__Affiliation__c>();
    
    for(Contact con : newList){
        if(con.AccountId != oldMap.get(con.Id).AccountId && oldMap.get(con.Id).AccountId != null){
            accountIds.add(oldMap.get(con.Id).AccountId);
            contactIds.add(con.Id);
        }  
    }
    
    if(!accountIds.isEmpty()){
        List<npe5__Affiliation__c> existingAffiliation = [select id,
                                                          npe5__Organization__c
                                                          from npe5__Affiliation__c
                                                          WHERE npe5__Organization__c In:accountIds AND npe5__Contact__c IN: contactIds];
        if(existingAffiliation.size()>0){
            for(npe5__Affiliation__c affObj : existingAffiliation){
                existingAccountIds.add(affObj.npe5__Organization__c);
            }
        }
        
        for(Contact con : newList){

            if(!existingAccountIds.contains(oldMap.get(con.Id).AccountId)){
                insertAffiliation.add(affiliationInstance(con.Id,oldMap.get(con.Id).AccountId));
            }
        }
    }
    if(insertAffiliation.size()>0){
        insert insertAffiliation;
    }
}

public static npe5__Affiliation__c affiliationInstance(String conId, String accId){
    npe5__Affiliation__c aff = new npe5__Affiliation__c();
    aff.npe5__Contact__c = conId;
    aff.npe5__Organization__c = accId;
    return aff;
}

}

/*
public class Fon_ContactTriggerHelper {
    public static void createAffiliation(List<Contact> newList, Map<Id,Contact> oldMap){
        Set<Id> accountIds = new Set<Id>();
        Set<Id> existingAccountIds = new Set<Id>();
        Set<Id> contactIds = new Set<Id>();
        List<npe5__Affiliation__c> insertAffiliation = new  List<npe5__Affiliation__c>();
        
        for(Contact con : newList){
            system.debug('con.Account --->'+con.AccountId);
 
            //system.debug('con.Account.RecordTypeId --->'+con.AccountId.Type);
            if(con.AccountId != oldMap.get(con.Id).AccountId && oldMap.get(con.Id).AccountId != null){
                accountIds.add(oldMap.get(con.Id).AccountId);
                contactIds.add(con.Id);
            }  
        }
        
        if(!accountIds.isEmpty()){
            List<npe5__Affiliation__c> existingAffiliation = [select id,
                                                              npe5__Organization__c
                                                              from npe5__Affiliation__c
                                                              WHERE npe5__Organization__c In:accountIds AND npe5__Contact__c IN: contactIds];
            if(existingAffiliation.size()>0){
                for(npe5__Affiliation__c affObj : existingAffiliation){
                    existingAccountIds.add(affObj.npe5__Organization__c);
                }
            }
            
            for(Contact con : newList){
                
                if(!existingAccountIds.contains(oldMap.get(con.Id).AccountId)){
                    insertAffiliation.add(affiliationInstance(con.Id,oldMap.get(con.Id).AccountId));
                }
            }
        }
        if(insertAffiliation.size()>0){
            insert insertAffiliation;
        }
    }
    
    public static npe5__Affiliation__c affiliationInstance(String conId, String accId){
        npe5__Affiliation__c aff = new npe5__Affiliation__c();
        aff.npe5__Contact__c = conId;
        aff.npe5__Organization__c = accId;
        return aff;
    }
    
    
    
    public static void setupAffiliationByIntegrationUser(List<Contact> lstContact, Map<Id, Contact> mapIdToObjContact){
        String contactRecordType = 'Contacts';
        String healthyStep = 'HealthySteps Contacts';
        String strHealthyNationalUserName = 'HealthySteps National Office1';
        
        Set<Id> setOfContactId = new Set<Id>();
        Set<Id> setOfAccId = new Set<Id>();
        Set<Id> setOfUserId = new Set<Id>();
        for(Contact eachContact : lstContact){
            setOfAccId.add(eachContact.AccountId);
            setOfContactId.add(eachContact.Id);
            setOfUserId.add(eachContact.LastModifiedById);
        }
        for(Contact oldContact : mapIdToObjContact.values()){
            setOfAccId.add(oldContact.AccountId);
            setOfContactId.add(oldContact.Id);
            setOfUserId.add(oldContact.LastModifiedById);
        }
        Map<Id,Account> mapIdToObjAccount = new Map<Id,Account>( [SELECT Id,RecordType.Name FROM Account WHERE Id IN : setOfAccId] );
        Map<Id,User> mapIdToObjUser = new Map<Id,User>( [SELECT Id,Name FROM User WHERE Id IN: setOfUserId AND Name =: strHealthyNationalUserName] );
        Map<Id,RecordType> mapIdToContactRecordType = new Map<Id,RecordType>( [SELECT Id,Name FROM RecordType WHERE  sObjectType = 'Contact'] );
        Set<String> setOfAccoutRecordTypeName = new Set<String>();
        setOfAccoutRecordTypeName.add('HealthySteps Site');
        setOfAccoutRecordTypeName.add('Household Account');
        setOfAccoutRecordTypeName.add('Potential HealthySteps Site');
        
        Map<String,npe5__Affiliation__c> mapKeyToObjAffiliation = fetchAffiliationRecord(setOfContactId, setOfAccId);
        List<npe5__Affiliation__c> lstAffiliation = new  List<npe5__Affiliation__c>();
        
        for(Contact eachContact : lstContact){
            Contact oldContact = mapIdToObjContact.get(eachContact.Id);
            Account newAccount = mapIdToObjAccount.get(eachContact.AccountId);
            Account oldAccount = mapIdToObjAccount.get(oldContact.AccountId);
            //Contact RecordTypeName
            RecordType newContactRecordType = mapIdToContactRecordType.get(eachContact.RecordTypeId);
            RecordType oldContactRecordType = mapIdToContactRecordType.get(oldContact.RecordTypeId);
            User objUser = mapIdToObjUser.get(eachContact.LastModifiedById);
            
            System.debug('===========oldContactRecordType========='+oldContactRecordType);
            System.debug('============newContactRecordType================'+newContactRecordType);
            System.debug('============newAccount================='+newAccount);
            System.debug('============oldAccount================='+oldAccount);
            System.debug('============objUser================='+objUser);
            
            
            if(oldContactRecordType != null && newContactRecordType != null && newAccount != null && oldAccount != null && objUser != null){
                //Account RecordTypeName
                String strNewAccountRecordtypeName = newAccount.RecordType.Name;
                String strOldAccountRecordtypeName = oldAccount.RecordType.Name;
                //User Name
                String strUserName = objUser.Name;
                //Key
                String strKey = ''+Id.valueOf(eachContact.Id) + Id.valueOf(eachContact.AccountId);
                
                
                System.debug('-------------------------------'+oldContactRecordType.Name.equalsIgnoreCase(contactRecordType));
                System.debug('-------------------------------'+newContactRecordType.Name.equalsIgnoreCase(healthyStep));
                System.debug('-------------------------------'+(!setOfAccoutRecordTypeName.contains(strOldAccountRecordtypeName)));
                System.debug('-------------------------------'+setOfAccoutRecordTypeName.contains(strNewAccountRecordtypeName));
                System.debug('-------------------------------'+(!mapKeyToObjAffiliation.containsKey(strKey)));
                
                
                
                //Checking condition here
                if( oldContactRecordType.Name.equalsIgnoreCase(contactRecordType) && newContactRecordType.Name.equalsIgnoreCase(healthyStep) && 
                    !setOfAccoutRecordTypeName.contains(strOldAccountRecordtypeName) && setOfAccoutRecordTypeName.contains(strNewAccountRecordtypeName) && 
                      strUserName.equalsIgnoreCase(strHealthyNationalUserName) && 
                      !mapKeyToObjAffiliation.containsKey(strKey) ){
                           
                    lstAffiliation.add( affiliationInstance(eachContact.Id, oldContact.AccountId) );
                }
            }
            System.debug('###################################'+lstAffiliation);
            if(!lstAffiliation.isEmpty()){
                insert lstAffiliation;
                
            }
            
        }
        
        
    }
    
    public static Map<String,npe5__Affiliation__c> fetchAffiliationRecord(Set<Id> setOfContactId, Set<Id> setOfAccId){
        Map<String,npe5__Affiliation__c> mapKeyToObjAffiliation = new Map<String,npe5__Affiliation__c>();
        List<npe5__Affiliation__c> existingAffiliation = [SELECT id,npe5__Organization__c,npe5__Contact__c FROM npe5__Affiliation__c 
                                                              WHERE npe5__Organization__c In: setOfAccId AND npe5__Contact__c IN: setOfContactId];
        for(npe5__Affiliation__c eachAffiliation : existingAffiliation){
            String strKey = ''+Id.valueOf(eachAffiliation.npe5__Contact__c) + Id.valueOf(eachAffiliation.npe5__Organization__c);
            mapKeyToObjAffiliation.put(strKey, eachAffiliation);
        }
        return mapKeyToObjAffiliation;
    }
    
   
}*/