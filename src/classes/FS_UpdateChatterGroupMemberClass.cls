public class FS_UpdateChatterGroupMemberClass {
    public static List<PagesApi__Community_Group_Member__c> updateChatterGroupMember(List<PagesApi__Community_Group_Member__c> cgmList){
        Set<Id> conId = new Set<Id>();//Contacts Id set
        Set<String> chatterGroupMemberIds = new Set<String>();//chatter group member ids set
        Set<Id> communityGroupsIds = new Set<Id>();//community group ids set

        for (PagesApi__Community_Group_Member__c cgm : cgmList){
            if (cgm.PagesApi__Contact__c != null) {
                conId.add(cgm.PagesApi__Contact__c);
            }
            if (cgm.PagesApi__Chatter_Group_Member_Id__c != null) {
                chatterGroupMemberIds.add(cgm.PagesApi__Chatter_Group_Member_Id__c);
            }
            if (cgm.PagesApi__Community_Group__c != null) {
                communityGroupsIds.add(cgm.PagesApi__Community_Group__c);
            }
        }

        Map<Id, Contact> conMap = new Map<Id, Contact>([SELECT Id FROM Contact WHERE Id IN : conId]); // Contacts map
        List<User> usersList = [SELECT Id, isActive, ContactId FROM User WHERE ContactId IN : conId]; // Users list
        Map<Id, User> usersMap = new Map<Id, User>(); // Users map from above users list

        for (User userInLoop : usersList) {
            usersMap.put(userInLoop.contactId, userInLoop);
        }
        Map<Id, PagesApi__Community_Group__c> communityGroupsMap = new Map<Id, PagesApi__Community_Group__c>([
                SELECT Id, Name, PagesApi__Chatter_Group_Id__c, PagesApi__Community_Network_ID__c
                FROM PagesApi__Community_Group__c
                WHERE Id IN :communityGroupsIds
        ]);
        Set<Id> chatterGroupIds = new Set<Id>();//chatter group ids set
        for (PagesApi__Community_Group__c cg : communityGroupsMap.values()){
            chatterGroupIds.add(cg.PagesApi__Chatter_Group_Id__c);
        }
        Map<Id, CollaborationGroup> chatterGroupsMap = new Map<Id, CollaborationGroup>([
                SELECT Id, Name
                FROM CollaborationGroup
                WHERE Id IN :chatterGroupIds
        ]);
        Map<Id,CollaborationGroupMember> chatterGroupMembersMap = new Map<Id,CollaborationGroupMember>([
                SELECT Id
                FROM CollaborationGroupMember
                WHERE Id IN :chatterGroupMemberIds
        ]);
        Map<Id, Id> userIdToChatterIdMap = getUserIdToChatterIdMap(usersList);

        List<CollaborationGroupMember> cgmListToDelete = new List<CollaborationGroupMember>();
        List<PagesApi__Community_Group_Member__c> groupMembersToUpdate = new List<PagesApi__Community_Group_Member__c>();
        for (PagesApi__Community_Group_Member__c cgm : cgmList) {
            Contact conFromMap = conMap.get(cgm.PagesApi__Contact__c);
            User oneUser = usersMap.get(conFromMap.Id);
            //if (conMap != null && oneUser != null && oneUser.IsActive == true && cgm.PagesApi__Status__c == 'Deactivated' &&
            //        cgm.PagesApi__Contact__c == oneUser.ContactId && chatterGroupMembersMap.get(cgm.PagesApi__Chatter_Group_Member_Id__c) != null){
            if (conMap != null && oneUser != null && oneUser.IsActive == true && cgm.PagesApi__Status__c != 'Active' &&
                    cgm.PagesApi__Contact__c == oneUser.ContactId && chatterGroupMembersMap.get(cgm.PagesApi__Chatter_Group_Member_Id__c) != null){
                CollaborationGroupMember cgmToDeactivate = chatterGroupMembersMap.get(cgm.PagesApi__Chatter_Group_Member_Id__c);
                cgmListToDelete.add(cgmToDeactivate);
                cgm.PagesApi__Chatter_Group_Member_Id__c = '';
                groupMembersToUpdate.add(cgm);
            }
            else if (cgm.PagesApi__Chatter_Group_Member_Id__c != '' && cgm.PagesApi__Chatter_Group_Member_Id__c != null && chatterGroupMembersMap.get(cgm.PagesApi__Chatter_Group_Member_Id__c) == null){
                cgm.PagesApi__Chatter_Group_Member_Id__c = '';
                groupMembersToUpdate.add(cgm);
            }
            else if (conMap != null && oneUser != null && oneUser.IsActive == true && cgm.PagesApi__Status__c == 'Active' &&
                    cgm.PagesApi__Contact__c == oneUser.ContactId && userIdToChatterIdMap.containsKey(oneUser.Id)) {
                cgm.PagesApi__Chatter_Group_Member_Id__c = userIdToChatterIdMap.get(oneUser.Id);
                groupMembersToUpdate.add(cgm);
            }
        }
        try {
            if (!cgmListToDelete.isEmpty()){
                delete cgmListToDelete;
            }
        }
        catch (Exception e){
            e.getMessage();
        }
        return groupMembersToUpdate;
    }

    private static Map<Id, Id> getUserIdToChatterIdMap(List<User> usersList) {
        List<CollaborationGroupMember> collaborationGroupMembers = new List<CollaborationGroupMember>([
                SELECT Id, MemberId
                FROM CollaborationGroupMember
                WHERE MemberId IN :usersList
        ]);
        Map<Id, Id> userIdToChatterIdMap = new Map<Id, Id>();
        for (CollaborationGroupMember collabMember : collaborationGroupMembers) {
            userIdToChatterIdMap.put(collabMember.MemberId, collabMember.Id);
        }
        return userIdToChatterIdMap;
    }
}