/**
 TO DELETE - LWK

    * Class Name : cfg_CreateCommunityUserBatch
    * Author: Lyndi Weener-Kuiper (lyndi@cloud4good.com)
    * Created Date: 11/5/2019
    * Last Modified Date: 11/5/2019
    * Description : This batch class exists to create new community users for the HS Portal, or activate existing users.  
    *               It runs at 8pm so that credentials can be sent out at a specified time after training session is completed. 
    *               This class will only run on contacts created or updated via FA which will be determined using a custom hidden checkbox.
    *               After User is created, hidden checkbox will be unchecked.
    *               
    *                Helper Classes -
    *                   - cfg_CreateCommunityUserHelper.cls is referenced by this class and contains most of the processing logic.  
    *                
Change log
------------------------------------------------------------------------------------------------
Author                        Date                                Reason
EightCloud                    7/2/2020                            To account for new community i. ITCP
                                                                  changed query condition at line 30  
------------------------------------------------------------------------------------------------
*/

global class cfg_CreateCommunityUserBatch implements Database.Batchable<SObject>, Database.Stateful {
    // ToDo: Make batch Database.Stateful to preserve variables
    // Create variable for Users to update 
    //public static Set<Id> usersToUpdate = new Set<Id>();
    public string adHocContactId;
    global Database.QueryLocator start(Database.BatchableContext BC) {
        // Query for Contacts that need Healthy Steps Portal access where community user is null
        if(String.isNotBlank(adHocContactId)){
          //return Database.getQueryLocator([SELECT Id, Email,ITCP_Community_Member__c,ITCP__c, Is_HealthySteps__c, FirstName, npe01__WorkEmail__c, LastName FROM Contact WHERE id= :adHocContactId AND ((Is_HealthySteps__c = TRUE AND cfg_CreatedbyFormAssembly__c = TRUE ) OR (ITCP_Community_Member__c = TRUE AND ITCP__c = TRUE)) AND cfg_Community_User__c = null]);
          return Database.getQueryLocator([SELECT Id, Email,ITCP_Community_Member__c,ITCP__c, Is_HealthySteps__c, FirstName, npe01__WorkEmail__c, LastName FROM Contact WHERE id= :adHocContactId AND ((Is_HealthySteps__c = TRUE AND cfg_CreatedbyFormAssembly__c = TRUE )) AND cfg_Community_User__c = null]);
        }else {
          //return Database.getQueryLocator([SELECT Id, Email,ITCP_Community_Member__c,ITCP__c, Is_HealthySteps__c, FirstName, npe01__WorkEmail__c, LastName FROM Contact WHERE ((Is_HealthySteps__c = TRUE AND cfg_CreatedbyFormAssembly__c = TRUE ) OR (ITCP_Community_Member__c = TRUE AND ITCP__c = TRUE)) AND cfg_Community_User__c = null]);
          return Database.getQueryLocator([SELECT Id, Email,ITCP_Community_Member__c,ITCP__c, Is_HealthySteps__c, FirstName, npe01__WorkEmail__c, LastName FROM Contact WHERE ((Is_HealthySteps__c = TRUE AND cfg_CreatedbyFormAssembly__c = TRUE )) AND cfg_Community_User__c = null]);
        }
    }

    global void execute(Database.BatchableContext BC, List<Contact> contacts) {
        // declare variables
        Map<Id, Contact> contactsToUpdate = new Map<Id, Contact>();
        // check for existing users to update & create new users
        List<User> newUsers = cfg_CreateCommunityUserHelper.createNewUsers(contacts);
        if (!newUsers.isEmpty()) {
            // stamp contact user id field with new user
            List<Contact> contactsStampedWithUser = cfg_CreateCommunityUserHelper.updateContactUserId(newUsers);
            // add to map to update
            contactsToUpdate.putAll(contactsStampedWithUser);
        }

        // Update Contacts to uncheck cfg_CreatedbyFormAssembly__c for those with users created
        for (Contact con : contacts) {
            if (contactsToUpdate.containsKey(con.Id)) {
                // if contact is already slated to be updated with community user id, don't override that field
                Contact existingCon = contactsToUpdate.get(con.Id);
                existingCon.cfg_CreatedbyFormAssembly__c = false;
                contactsToUpdate.put(existingCon.Id, existingCon);
            }
        }

        // Update contacts
        update contactsToUpdate.values();

    }

    global void finish(Database.BatchableContext BC) {
        // send email to admin notifying of successful batch run
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, 
            JobItemsProcessed,
            TotalJobItems, CreatedBy.Email
            FROM AsyncApexJob
            WHERE Id = :BC.getJobId()];

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(new String[]{job.CreatedBy.Email});
        mail.setSubject('Create Community User Batch Status: ' + job.Status);
        mail.setPlainTextBody('The batch job with Id: ' + job.Id + ' for Creating Community Users processed ' + job.JobItemsProcessed + ' batch with ' + job.NumberOfErrors + ' errors.' );
        if (!Test.isRunningTest()) {
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        }
    }
}