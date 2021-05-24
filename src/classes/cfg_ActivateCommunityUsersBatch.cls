/**
    * Class Name : cfg_ActivateCommunityUsersBatch
    * Author: Lyndi Weener-Kuiper (lyndi@cloud4good.com)
    * Created Date: 11/5/2019
    * Last Modified Date: 1/13/2019
    * Description : This schedulable class exists for scheduling a nightly activation of Healthy Steps Community Users.
    *               
    *               Note: This is running as scheduled apex but not a batch d/t errors coming from Fonteva while activating Users from a batch.
    *                     The Fonteva Managed Packaged had a trigger that was making future calls on User update which caused the batch to fail since 
    *                     future calls are not permissible from a batch.  
    *              
    *                
Change log
------------------------------------------------------------------------------------------------
Author                        Date                                Reason
EightCloud                    7/2/2020                            To account for new community i. ITCP
                                                                  changed query condition at line 23  
------------------------------------------------------------------------------------------------    
*/
global class cfg_ActivateCommunityUsersBatch implements Schedulable {
    public string adHocContactId; 
    global void execute (SchedulableContext SC) {
        
        List<Contact> contacts = new List<Contact> ();
        if(String.isNotBlank(adHocContactId)){
         // contacts = [SELECT Id, Email, Is_HealthySteps__c, cfg_Flag_for_Password_Reset__c, cfgHSPortalUserActive__c, FirstName, cfg_Community_User__c, npe01__WorkEmail__c, LastName FROM Contact WHERE id = :adHocContactId AND ((Is_HealthySteps__c = TRUE AND cfg_CreatedbyFormAssembly__c = TRUE) OR (ITCP_Community_Member__c = TRUE AND ITCP__c = TRUE)) AND cfg_Community_User__c != null];
            contacts = [SELECT Id, Email, Is_HealthySteps__c, cfg_Flag_for_Password_Reset__c, cfgHSPortalUserActive__c, FirstName, cfg_Community_User__c, npe01__WorkEmail__c, LastName FROM Contact WHERE id = :adHocContactId AND ((Is_HealthySteps__c = TRUE AND cfg_CreatedbyFormAssembly__c = TRUE)) AND cfg_Community_User__c != null];
        }
        else {
         // contacts = [SELECT Id, Email, Is_HealthySteps__c, cfg_Flag_for_Password_Reset__c, cfgHSPortalUserActive__c, FirstName, cfg_Community_User__c, npe01__WorkEmail__c, LastName FROM Contact WHERE ((Is_HealthySteps__c = TRUE AND cfg_CreatedbyFormAssembly__c = TRUE) OR (ITCP_Community_Member__c = TRUE AND ITCP__c = TRUE)) AND cfg_Community_User__c != null];
           contacts = [SELECT Id, Email, Is_HealthySteps__c, cfg_Flag_for_Password_Reset__c, cfgHSPortalUserActive__c, FirstName, cfg_Community_User__c, npe01__WorkEmail__c, LastName FROM Contact WHERE ((Is_HealthySteps__c = TRUE AND cfg_CreatedbyFormAssembly__c = TRUE)) AND cfg_Community_User__c != null];
        }
                                    
        
        // declare variables
        List<Contact> contactsToUpdate = new List<Contact>();
        Set<Id> usersToActivate = new Set<Id>();
        Set<Id> usersToResetPW = new Set<Id>();

        // create set of user ids
        for (Contact con : contacts) {
            // if user is active & has been flagged for password reset, add to set to reset password
            if (con.cfgHSPortalUserActive__c && con.cfg_Flag_for_Password_Reset__c) {
                usersToResetPW.add(con.cfg_Community_User__c);
            } else if (!con.cfgHSPortalUserActive__c){  // if user is inactive, add to set to activate
                usersToActivate.add(con.cfg_Community_User__c);
            }
        }

        // send to helper to activate existing users, need to run in real time if running as test
        if (!usersToActivate.isEmpty()) {
            if ( Test.isRunningTest()) {
                cfg_CreateCommunityUserHelper.updateExistingUsers(usersToActivate);
            } else {
                cfg_CreateCommunityUserHelper.updateExistingUsersFuture(usersToActivate);
            }
        }
        
        // send to helper to reset password for existing active users
        if (!usersToResetPW.isEmpty()){
            cfg_CreateCommunityUserHelper.resetPasswords(usersToResetPW);
        }

        // Update Contacts to uncheck cfg_CreatedbyFormAssembly__c & cfg_Flag_for_Password_Reset__c, this needs to include all contacts in scope to prevent running through batch again
        for (Contact con : contacts) {
            con.cfg_CreatedbyFormAssembly__c = false;
            con.cfg_Flag_for_Password_Reset__c = false;
            contactsToUpdate.add(con);
        }
        system.debug('contactsToUpdate ' + contactsToUpdate);

        // Update contacts
        update contactsToUpdate;
    }

}