/**
 * Created by jason on 2/22/17.
 */

public class FS_BadgesUpdateBatchable implements Schedulable {
    String query;
    Set<Id> listOfAccountIds;
    Set<Id> listOfContactIds;

    // if null update every contact in the system
    public FS_BadgesUpdateBatchable(String queryIn) {
    }

    public FS_BadgesUpdateBatchable(String query, Set<Id> accountIds, Set<Id> contactIds){
        if(query == null) {
            this(null);
        } else {
            this.query = query;
            listOfAccountIds = accountIds;
            listOfContactIds = contactIds;
        }
    }


    public void execute(SchedulableContext BC) {
        for (Contact currContact : [SELECT Id FROM Contact WHERE Id IN :listOfContactIds]) {
            OrderApi.Contacts.updateContactBadges(currContact.Id);
        }
    }

}