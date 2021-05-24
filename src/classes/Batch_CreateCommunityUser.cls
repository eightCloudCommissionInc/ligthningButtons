global class Batch_CreateCommunityUser implements Database.Batchable<SObject>, Database.Stateful {
  list<string> lstContactIds;
  
  
  list<Id> lstContactSuccess = new list<Id>();
  list<string> lstContactError = new list<string>();
  list<Id> lstContactSkip = new list<Id>();
  list<string> lstUserSuccess = new list<string>();
  list<string> lstUserError = new list<string>();
  public Batch_CreateCommunityUser(list<string> lstContactId) {
    lstContactIds = lstContactId;
  }
  global Database.QueryLocator start(Database.BatchableContext BC) {
    if(lstContactIds != NULL && !lstContactIds.isEmpty())
    return Database.getQueryLocator([SELECT Id, Email, ITCP_Community_Member__c,ITCP__c, FirstName, npe01__WorkEmail__c, LastName FROM Contact WHERE id IN: lstContactIds AND ITCP__c = TRUE AND ITCP_Community_Member__c = FALSE AND Email != NULL]);    
    return Database.getQueryLocator([SELECT Id, Email, ITCP_Community_Member__c,ITCP__c, FirstName, npe01__WorkEmail__c, LastName FROM Contact WHERE ITCP__c = TRUE AND ITCP_Community_Member__c = FALSE AND Email != NULL]);    
  }
  
  global void execute(Database.BatchableContext BC, List<Contact> lstContact) {
    map<String,Contact> mpContact = new map<String,Contact>();
    for(Contact c : lstContact) {
      c.ITCP_Community_Member__c = true;
      mpContact.put(c.email,c);
    }
    Database.SaveResult[] srUpdateList =  Database.update(lstContact,false);
    map<id,Contact> mpContactToUser = new map<id,Contact>();
    Integer index = 0;  
        for (Database.SaveResult sr : srUpdateList) {                
            if (sr.isSuccess()) {                   
              lstContactSuccess.add(sr.getId());
              mpContactToUser.put(lstContact[index].id,lstContact[index]);                
            }
            else {                                
              for(Database.Error err : sr.getErrors()) {                              
                lstContactError.add(lstContact[index].id+','+err);
              }
            }     
            index++;        
        }
    
    map<string,user> mpExistingUser = new map<string,user>();
    set<id> stContactIdUser = new set<id>();
    for(User u : [Select id,Contactid,Email,username from USER where username IN :mpContact.keySet() OR ContactId IN :mpContactToUser.keySet()]) {
      mpExistingUser.put(u.username,u);
      if(u.contactid !=null)stContactIdUser.add(u.contactid);
    }
    
    list<Contact> lstContactToUser2 = new list<Contact>();
    for(Contact c : mpContactToUser.values()) {
      if(mpExistingUser.containsKey(c.Email) || stContactIdUser.contains(c.id)) {
        lstContactSkip.add(c.id);
        continue;
      }
      lstContactToUser2.add(c);
    }
    
    List<Profile> lstProfile = [select id from profile where name = 'Fonteva Customer Community Login User'];
    list<User> lstUser = new list<User> ();
    for(Contact c : lstContactToUser2) {     
      User u = new User();
      u.Profileid = lstProfile[0].id;
      u.ContactId = c.id;
      u.FirstName = c.Firstname;
      u.Email = c.email;
      u.Username = c.email;
      u.LastName = c.lastname;
      u.alias = c.lastname.length() > 5 ? c.lastname.substring(0,5) : c.lastname;
      u.LocaleSidKey =  'en_US';
      u.LanguageLocaleKey =   'en_US'; 
      u.EmailEncodingKey =  'UTF-8';   
      u.TimezoneSidKey =   'America/New_York';           
      lstUser.add(u);       
    }    
    Database.SaveResult[] srInsertList = Database.insert(lstUser,false);
    index = 0;  
    for (Database.SaveResult sr : srInsertList) {                
      if (sr.isSuccess()) {                           
        lstUserSuccess.add(lstContactToUser2[index].id+','+sr.getid());             
      }
      else {                                
        for(Database.Error err : sr.getErrors()) {                              
          lstUserError.add(lstContactToUser2[index].id+','+err);
        }
      }     
      index++;        
    }
    
  }
  global void finish(Database.BatchableContext BC) {
    String conSuc = string.join(lstContactSuccess,'\n');
    String conError = string.join(lstContactError,'\n');
    String conSkip = string.join(lstContactSkip,'\n');
    String usrSuc = string.join(lstUserSuccess,'\n');
    String usrError = string.join(lstUserError,'\n');
    
    Messaging.EmailFileAttachment csvAttachment = new Messaging.EmailFileAttachment();    
    csvAttachment.setFileName('Contacts Successfully Updated.csv');
    csvAttachment.setBody(blob.valueOf(conSuc));
    csvAttachment.setcontenttype('application/vnd.ms-excel');
    
    Messaging.EmailFileAttachment csvAttachment1 = new Messaging.EmailFileAttachment();    
    csvAttachment1.setFileName('Contacts Update Failed.csv');
    csvAttachment1.setBody(blob.valueOf(conError));
    csvAttachment.setcontenttype('application/vnd.ms-excel');
        
    Messaging.EmailFileAttachment csvAttachment2 = new Messaging.EmailFileAttachment();    
    csvAttachment2.setFileName('Contacts Skipped User Creation.csv');
    csvAttachment2.setBody(blob.valueOf(conSkip));
    csvAttachment.setcontenttype('application/vnd.ms-excel');
        
    Messaging.EmailFileAttachment csvAttachment3 = new Messaging.EmailFileAttachment();    
    csvAttachment3.setFileName('User Successfully Created.csv');
    csvAttachment3.setBody(blob.valueOf(usrSuc));
    csvAttachment.setcontenttype('application/vnd.ms-excel');
        
    Messaging.EmailFileAttachment csvAttachment4 = new Messaging.EmailFileAttachment();    
    csvAttachment4.setFileName('User Creation Failed.csv');
    csvAttachment4.setBody(blob.valueOf(usrError));
    csvAttachment.setcontenttype('application/vnd.ms-excel');
        
    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
    String[] toAddresses = Label.CommunityUserMailingList.split(','); //new String[]{'techcloudo@gmail.com'};
    
    String subject = 'Community user creation batch completed';
    email.setSubject(subject);
    email.setToAddresses(toAddresses);
    email.setPlainTextBody('Please find attched filed with details of success and failures');
    list<Messaging.EmailFileAttachment> lstFileAttachment = new list<Messaging.EmailFileAttachment>();
    if(!lstContactSuccess.isEmpty())lstFileAttachment.add(csvAttachment);
    if(!lstContactError.isEmpty())lstFileAttachment.add(csvAttachment1);
    if(!lstContactSkip.isEmpty())lstFileAttachment.add(csvAttachment2);
    if(!lstUserSuccess.isEmpty())lstFileAttachment.add(csvAttachment3);
    if(!lstUserError.isEmpty())lstFileAttachment.add(csvAttachment4);
    
    email.setFileAttachments(lstFileAttachment);
    Messaging.SendEmailResult[] r = Messaging.sendEmail(new Messaging.SingleEmailMessage[]{email});
  }
  /*
  public class ErrorClass {
    public id cId;
    public string errMsg;
    public ErrorClass(id ci,Database.Error err) {
      cId = ci;
      errMsg = err.getMessage();
    }
  }
  
  
  public class SuccessClass {
    public id cId;
    public id uid;
    public SuccessClass(id ci,Id ui) {
      cId = ci;
      uid = ui;
    }
  }*/
}