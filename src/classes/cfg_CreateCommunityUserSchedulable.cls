/**
    * Class Name : cfg_CreateCommunityUserSchedulable
    * Author: Lyndi Weener-Kuiper (lyndi@cloud4good.com)
    * Created Date: 11/5/2019
    * Last Modified Date: 1/13/2019
    * Description : This schedulable class exists for scheduling a nightly  creation of Healthy Steps Community Users.
    *                
*/
global class cfg_CreateCommunityUserSchedulable implements Schedulable {
    global void execute (SchedulableContext SC) {
        cfg_CreateCommunityUserBatch userBatch = new cfg_CreateCommunityUserBatch();
        Database.executeBatch(userBatch);
    }
}