/**
    * Class Name : TestDataFactory
    * Author: Lyndi Weener-Kuiper (lyndi@cloud4good.com)
    * Created Date: 10/23/2019
    * Last Modified Date: 10/23/2019
    * Description : This class contains the methods to build test data for test classes to use. 
    *              
    * 				 
*/

public class TestDataFactory {

    /*
     * Creates single contact with random string FN & LN. 
     * 
    */
    public static Contact createContact() {
        Contact con = new Contact(
            FirstName=generateRandomString(5),
            LastName=generateRandomString(5),
            Email=generateRandomString(5) + '@gmail.com',
            npe01__WorkEmail__c=generateRandomString(5) + '@gmail.com'
        );

        return con;
    }


    /*
     * Creates multiple contact records with random string FN & LN. 
     * 
    */
    public static List<Contact> createContacts(Integer numContacts) {
        List<Contact> contacts = new List<Contact>();
        for(Integer i=0;i<numContacts;i++) { 
            Contact con = new Contact(
                FirstName=generateRandomString(5),
                LastName=generateRandomString(5),
                Email=generateRandomString(5) + '@gmail.com',
                npe01__WorkEmail__c=generateRandomString(5) + '@gmail.com'
            );
            contacts.add(con);
        }

        return contacts;
    }

    /*
     * Creates single account with random string name.
     * 
    */
    public static Account createAccount() {
        Account acc = new Account(
            Name=generateRandomString(7)
        );

        return acc;
    }

    /*
     * Creates single community user with passed in profile Id & contact
     * 
    */
    public static User createCommunityUser(Contact con, Id profileId) {
        User user = new User(
            ContactId = con.Id,
            Alias = con.LastName.left(8),
            Email = con.Email,
            FirstName = con.FirstName,
            LastName = con.LastName,
            CommunityNickname = con.LastName.left(8),
            TimeZoneSidKey = 'America/New_York',
            LocaleSidKey = 'en_US',
            LanguageLocaleKey = 'en_US',
            Username = con.Email,
            IsActive = false,
            ProfileId = profileId,
            EmailEncodingKey = 'ISO-8859-1',
            UserPreferencesReceiveNoNotificationsAsApprover = false,
            UserPreferencesReceiveNotificationsAsDelegatedApprover = false
        );

        return user;
    }

    /*
     * Generates the random character strings used by a lot of methods in this class for name and required text fields.
     * 
    */
    public static String generateRandomString(Integer len) {
        final String chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz';
        String randStr = '';
        while (randStr.length() < len) {
            Integer idx = Math.mod(Math.abs(Crypto.getRandomInteger()), chars.length());
            randStr += chars.substring(idx, idx+1);
        }
        return randStr; 
    }
}