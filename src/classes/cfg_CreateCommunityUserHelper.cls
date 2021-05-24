/**
    * Class Name : cfg_CreateCommunityUserHelper
    * Author: Lyndi Weener-Kuiper (lyndi@cloud4good.com)
    * Created Date: 10/23/2019
    * Last Modified Date: 10/23/2019
    * Description : The methods in this class are called from cfg_CreateCommunityUser_TDTM.
    *               Methods have detailed information with inputs & outputs listed.
    *              
    *                
*/
public without sharing class cfg_CreateCommunityUserHelper {
   
    /*
     * Description: Method used to check for existing Community Users to be activated
     *              
     * Inputs: 
     *   contactsToCheck - list of contacts being inserted or updated
     * Outputs: 
     *   newUsers - a list of new users that were created
     * 
    */

    public static List<User> checkForExistingUsers(List<Contact> contactsToCheck) {
        // declare variables;
        Profile communityProfile = [SELECT Id FROM Profile WHERE Name = 'Fonteva Customer Community Login User'];
        Set<Id> contactIds = (new Map<Id, Contact>(contactsToCheck)).keySet();
        List<User> existingUsers = new List<User>();
        List<Contact> conNeedingNewUser = new List<Contact>();
        Set<Id> contactsWithUsersToUpdate = new Set<Id>();
        List<User> newUsers = new List<User>();

        // search for existing users
        existingUsers = [SELECT Id, ContactId, IsActive FROM User WHERE ContactId IN :contactIds AND ProfileId =:communityProfile.Id];
        system.debug('existingUsers ' + existingUsers);

        // if users already exist
        if (!existingUsers.isEmpty()) {
            Set<Id> usersToActivate = new Set<Id>();
            // if they are not currently active, activate them
            for (User u : existingUsers) {
                // add contact to set to return to TDTM class so it knows which contacts still need new users
                contactsWithUsersToUpdate.add(u.ContactId);
                // if user is not active, add to set to activate
                usersToActivate.add(u.Id);
            }
            // if users to activate is not empty, pass to future call to activate & avoid mixed dml error
            // unless test is running, need to run not as future in order to assert users successfully activated
            if (!usersToActivate.isEmpty()) {
                updateExistingUsersFuture(usersToActivate);
            }
        }
        
        // loop through contactsToCheck to determine which users still need to be created
        for (Contact con: contactsToCheck) {
            // if contact id is not in list of users to update, add to list of users to create
            if (!contactsWithUsersToUpdate.contains(con.Id)) {
                conNeedingNewUser.add(con);
            }
        }

        if (!conNeedingNewUser.isEmpty()) {
            // create new users for remaining contacts
            newUsers = cfg_CreateCommunityUserHelper.createNewUsers(conNeedingNewUser);
        }
       
        return newUsers;
    }

    /*
     * Description: Method used to update existing community users as active.  
     *              This is not run in future context because it is utilized from a batch & batches cannot call future methods
     *              
     * Inputs: 
     *   userIds - set of user ids needing to be activated
     * Outputs: 
     *   none 
     * 
    */

    public static void updateExistingUsers(Set<Id> userIds) {
        system.debug('updateExistingUsers');
        List<User> usersToUpdate = new List<User>();

        for (Id userId : userIds) {
            User u = new User();
            u.Id = userId;
            u.IsActive = true;
            usersToUpdate.add(u);
        }

        // update users
        Database.SaveResult[] srList = Database.update(usersToUpdate, false);
    }

    /*
     * Description: Method used to reset passwords for existing & active community users
     *              
     * Inputs: 
     *   userIds - set of user ids needing passwords reset
     * Outputs: 
     *   none 
     * 
    */

    public static void resetPasswords(Set<Id> userIds) {
        system.debug('inside reset password');
        for (Id userId : userIds) {
            System.resetPassword(userId, true);
        }
    }

    /*
     * Description: Method used to update existing community users as active.  
     *              This needs to run in future to avoid MIXED_DML_OPERATION of updating contacts & users in the same operation.
     *              
     * Inputs: 
     *   userIds - set of user ids needing to be activated
     * Outputs: 
     *   none 
     * 
    */

    @future public static void updateExistingUsersFuture(Set<Id> userIds) {
        // declare variables
        List<User> usersToUpdate = new List<User>();

        for (Id userId : userIds) {
            User u = new User();
            u.Id = userId;
            u.IsActive = true;
            usersToUpdate.add(u);
        }

        // update users
        Database.SaveResult[] srList = Database.update(usersToUpdate, false);
        
    }

     /*
     * Description: Method used to update Community User Id field on contact after new user is created
     *              
     * Inputs: 
     *   users - list of community users that were just created
     * Outputs: 
     *   contactsToUpdate - list of contacts to update 
     * 
    */

    public static List<Contact> updateContactUserId(List<User> users) {
        List<Contact> contactsToUpdate = new List<Contact>();

        for (User u : users) {
            Contact con = new Contact();
            con.Id = u.ContactId;
            con.cfg_Community_User__c = u.Id;
            contactsToUpdate.add(con);
        }

        return contactsToUpdate;
    }

    /*
     * Description: Method used to update Community User Id field on contact when updated from FA
     *              
     * Inputs: 
     *   users - list of community contacts that were updated by FA & have a blank community user lookup
     * Outputs: 
     *   none
     * 
    */

    public static void updateContactUserId(List<Contact> contacts) {
        Set<Id> contactIds = new Map<Id, Contact>(contacts).keySet();

        List<User> existingUsers = [SELECT Id, ContactId FROM User WHERE ContactId IN :contactIds];

        if (!existingUsers.isEmpty()) {
            Map<Id, User> contactToUser = new Map<Id, User>();
            // create a map of contact id to user
            for (User existingUser : existingUsers) {
                contactToUser.put(existingUser.ContactId, existingUser);
            }
            // loop through contacts
            for (Contact con : contacts) {
                if (contactToUser.containsKey(con.Id)) {
                    con.cfg_Community_User__c = contactToUser.get(con.Id).Id;
                }
            }
        }
    }

    /*
     * Description: Method used to create new Fonteva Community Users
     *              
     * Inputs: 
     *   conNeedingNewUser - list of contacts being inserted or updated that don't already have existing user records
     * Outputs: 
     *   usersToCreate - list of new community users that were created
     * 
    */

    public static List<User> createNewUsers(List<Contact> conNeedingNewUser) {
        system.debug('createNewUsers');
        // declare variables
        Profile communityProfile = [SELECT Id FROM Profile WHERE Name = 'Fonteva Customer Community Login User'];
        Map<String, User> usersToCreate = new Map<String, User>();
        List<String> emails = new List<String>();
        Map<String, User> existingUsersMap = new Map<String, User>();
        List<User> createdUsers = new List<User>();
        List<cfg_HS_User_Batch_Creation_Error__c> logsToCreate = new List<cfg_HS_User_Batch_Creation_Error__c>();

        // double check a user doesn't already exist for email/username or nickname
        // loop through contacts to create a list of emails 
        for (Contact con : conNeedingNewUser) {
         // if(con.ITCP_Community_Member__c && con.ITCP__c){
         //   emails.add(con.Email);
         // }else {
            emails.add(con.npe01__WorkEmail__c  );
        //  }  
        }
        system.debug('emails ' + emails);
        // query user usernames or nicknames for contact emails
        List<User> existingUsers = [SELECT Id, Username, CommunityNickname FROM User WHERE Username IN :emails OR CommunityNickname IN :emails];
        // create a map for easier handling
        if (!existingUsers.isEmpty()) {
            for (User u : existingUsers) {
                existingUsersMap.put(u.Username, u);
                existingUsersMap.put(u.CommunityNickname, u);
            }
        }
        system.debug('existingUsers ' + existingUsersMap);

        for (Contact con : conNeedingNewUser) {
            
           // String email = (con.ITCP_Community_Member__c && con.ITCP__c) ? con.Email : con.npe01__WorkEmail__c ;
              String email = con.npe01__WorkEmail__c ;
            // if contact's email is not already in use by another user & there are no duplicates email in list passed in, create a new user
            if (String.isNotBlank(email) && !existingUsersMap.containsKey(email) && !usersToCreate.containsKey(email)) {
                system.debug('map does not contain existing user');
                User u = new User();
                u.ContactId = con.Id;
                u.Alias = createAlias(con);
                u.Email = email;
                u.FirstName = con.FirstName;
                u.LastName = con.LastName;
                u.CommunityNickname = email;
                u.TimeZoneSidKey = 'America/New_York';
                u.LocaleSidKey = 'en_US';
                u.LanguageLocaleKey = 'en_US';
                u.Username = email;
                u.IsActive = true;
                u.ProfileId = communityProfile.Id;
                u.EmailEncodingKey = 'ISO-8859-1';
                u.UserPreferencesReceiveNoNotificationsAsApprover = false;
                u.UserPreferencesReceiveNotificationsAsDelegatedApprover = false;
                usersToCreate.put(email, u);
             } 
        }

        // insert new users
        Database.SaveResult[] srList = Database.insert(usersToCreate.values(), false);
        // if a user was not successfully inserted, create new log
        for (Integer i=0; i<srList.size(); i++) {
            if (srList[i].isSuccess()){
                createdUsers.add(usersToCreate.values()[i]);
            } else if (!srList[i].isSuccess()) {
                cfg_HS_User_Batch_Creation_Error__c log = createLog('Create New User', usersToCreate.values()[i].ContactId, null, srList[i].getErrors());
                logsToCreate.add(log);
            }
        }

        if (!logsToCreate.isEmpty()) {
            insert logsToCreate;
        }
        // only return successfully created users
        return createdUsers;
    }

    
    /*
     * Description: Method used to create a User Alias based on Contact's First & Last Name
     *              
     * Inputs: 
     *   con - single contact needing an Alias
     * Outputs: 
     *   alias - alias created from contact's first initial of first name + last name
     * 
    */

    private static string createAlias(Contact con) {
        String alias = '';
        if (con.FirstName != null && con.FirstName != '') {
            alias += con.FirstName.left(1);
        }
        alias += con.LastName.left(7);
        return alias;
    }
    @testVisible
    private static cfg_HS_User_Batch_Creation_Error__c createLog(String processAttempted, Id contactId, Id userId, Database.Error[] errors) {
        cfg_HS_User_Batch_Creation_Error__c log = new cfg_HS_User_Batch_Creation_Error__c();
        log.cfg_Process_Attempted__c = processAttempted;
        if (contactId != null) {
            log.cfg_Related_Contact__c = contactId;
        }
        if (userId != null) {
            log.cfg_Related_User__c = userId;
        }
        String errMsg;
        for (Database.Error err : errors) {
            errMsg += err.getMessage() + '\n';
        }
        log.cfg_Error_Message__c = errMsg;
        return log;
    }
}