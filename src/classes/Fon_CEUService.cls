/**************************************************************************************************************************************************************************************************************************************************************
Name            :-  Fon_CEUService
Created Date    :-  11/21/2018
Updated Date    :-  
Created By      :-  Arpita Munjal
Dependencies    :-  
Description     :-  Service class Certification_and_CEU__c 
**************************************************************************************************************************************************************************************************************************************************************/

public without sharing class Fon_CEUService {
    
    
    public static void updateAttendeeCEU(Certification_and_CEU__c[] records, Map<Id,Contact> oldMap) {
        // this method is for both update,create users
        Framework.Log.push(Fon_CEUService.class.getName(),'updateAttendeCEU');
        map<string,Certification_and_CEU__c> itemContactIds = new  map<string,Certification_and_CEU__c> ();  
        map<string,Certification_and_CEU__c> attendeeCEUs = new  map<string,Certification_and_CEU__c> ();     
        List<EventApi__Registration_Item__c> regItems = new list<EventApi__Registration_Item__c>(); 
        List<EventApi__Attendee__c> attendeesUpdate = new list<EventApi__Attendee__c>(); 
        List<EventApi__Attendee__c> onlyattendeesUpdate = new list<EventApi__Attendee__c>();       
        for(Certification_and_CEU__c ceu:records){
        	if(ceu.FON_Item__c != null){
        		itemContactIds.put(ceu.Contact__c,ceu);
        	}
        }//system.debug(' '+itemContactIds);
        //system.debug('!!!IN CONTACT SERVICE!!!');
      	if(itemContactIds.size() > 0){
      		regItems = [select id,EventApi__Attendee__c,AttendeeContact__c,EventApi__Item__c from EventApi__Registration_Item__c where AttendeeContact__c IN:itemContactIds.keyset() limit 49999];
             //system.debug('!!!IN CONTACT SERVICEregItems!!!'+regItems);
            if(regItems.size()>0){
                for(EventApi__Registration_Item__c b : regItems){
                	//system.debug('--1EQuAl='+b.EventApi__Item__c);
                	if(itemContactIds.get(b.AttendeeContact__c) !=null && (itemContactIds.get(b.AttendeeContact__c).FON_Item__c == b.EventApi__Item__c)){
                		//get and update the Attendee CEU's
                		attendeeCEUs.put(b.EventApi__Attendee__c,itemContactIds.get(b.AttendeeContact__c));
                	}
                    
                }
                //system.debug('attendeeCEUs='+attendeeCEUs.size());
                if(attendeeCEUs.size() > 0){
                	attendeesUpdate = [select id,EventApi__Contact__c,EventApi__Is_Registered__c from EventApi__Attendee__c where EventApi__Status__c = 'Registered' AND Id IN:attendeeCEUs.keyset() limit 49999];
		            if(attendeesUpdate.size()>0){
		                for(EventApi__Attendee__c attn : attendeesUpdate){
		                	if(attendeeCEUs.get(attn.id) !=null){
		                		//update the Attendee CEU's
		                		attn.CEU_Credits__c = attendeeCEUs.get(attn.id).FON_Number_of_Credits__c;
		                		attn.CEU_hours__c = attendeeCEUs.get(attn.id).FON_Contact_Hours__c;
		                		attn.CEU_name__c = attendeeCEUs.get(attn.id).name;
		                		onlyattendeesUpdate.add(attn);
		                		//system.debug('-----FINAl'+attn);
		                	}
		                    
		                }
		                //system.debug('====='+onlyattendeesUpdate);
		                if(onlyattendeesUpdate.size() > 0)
		                	update onlyattendeesUpdate;

		            }
                }
            }
      	}
        Framework.Log.pop();
    
    }


        
}