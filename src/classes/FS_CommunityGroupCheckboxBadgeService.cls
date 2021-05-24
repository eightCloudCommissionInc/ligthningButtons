/**
 * Created by daweima on 7/22/20.
 */

public without sharing class FS_CommunityGroupCheckboxBadgeService {

    public static void setCGMStatus(List<Contact> records, Map<Id, SObject> oldMap, String cgmId, String checkboxId, String badgeId) {
        Id privateCommunityGroupId = cgmId;
        List<PagesApi__Community_Group_Member__c> comGroupMembersToCreate = new List<PagesApi__Community_Group_Member__c>();
        List<Id> contactsIdToDeactivate = new List<Id>();
        List<Id> contactsIdToActive = new List<Id>();
        List<Id> contactIds = new List<Id>();
        Map<Id, PagesApi__Community_Group_Member__c> contactToCgmMap = new Map<Id, PagesApi__Community_Group_Member__c>();
        SObjectField checkboxField = Schema.getGlobalDescribe().get('Contact').getDescribe().fields.getMap().get(checkboxId);

        for (Contact currCon :records){
            if (oldMap != null) {
                Contact oldContact = (Contact) oldMap.get(currCon.Id);
                if (oldContact.get(checkboxField) != currCon.get(checkboxField)) {
                    contactIds.add(currCon.Id);
                }
            } else {
                contactIds.add(currCon.Id);
            }
        }
        if (!contactIds.isEmpty()) {
            List<PagesApi__Community_Group_Member__c> existCGM = [
                    SELECT Id, PagesApi__Is_Active__c, PagesApi__Contact__c
                    FROM PagesApi__Community_Group_Member__c
                    WHERE PagesApi__Community_Group__c = :privateCommunityGroupId
                    AND PagesApi__Contact__c IN :contactIds
            ];

            for (PagesApi__Community_Group_Member__c currCgm : existCGM) {
                contactToCgmMap.put(currCgm.PagesApi__Contact__c, currCgm);
            }
            insertUpdateCGM(records, contactToCgmMap, comGroupMembersToCreate, contactsIdToActive, contactsIdToDeactivate, cgmId, checkboxId);

            Set<Id> contactIdToUpdate = new Set<Id>();
            // deactivate cgm
            contactIdToUpdate = deactivateCGM(contactsIdToDeactivate, badgeId, cgmId);

            // badge for active cgm
            if (contactsIdToActive.size() != 0) {
                createBadge(contactsIdToActive, badgeId);
            }

            if (contactIdToUpdate != null) {
                Datetime dtTimeNow=System.now().addSeconds(60);
                String cronExpression = '' + dtTimeNow.second() + ' ' + dtTimeNow.minute() + ' ' + dtTimeNow.hour() + ' ' + dtTimeNow.day() + ' ' + dtTimeNow.month() +
                        ' ? ' + dtTimeNow.year();

                System.schedule('FS_BadgeUpdate_' + dtTimeNow, cronExpression,
                        new FS_BadgesUpdateBatchable('SELECT Id FROM Contact WHERE Id IN :listOfContactIds',null,contactIdToUpdate));
            }
        }
    }

    public static Set<Id> deactivateCGM(List<Id> contactsIdToDeactivate, Id badgeTypeId, String cgmId) {
        Set<Id> contactIds = new Set<Id>();
        if (contactsIdToDeactivate.size() != 0) {
            List<PagesApi__Community_Group_Member__c> relatedCGMToDeactivated = [
                    SELECT Id, PagesApi__Contact__c, PagesApi__Status__c
                    FROM PagesApi__Community_Group_Member__c
                    WHERE PagesApi__Contact__c IN :contactsIdToDeactivate
                    AND PagesApi__Community_Group__c = :cgmId
            ];

            for (PagesApi__Community_Group_Member__c currCGM : relatedCGMToDeactivated) {
                currCGM.PagesApi__Status__c = 'Deactivated';
            }
            update relatedCGMToDeactivated;

            List<OrderApi__Badge__c> relatedBadgesToDeactivate = [
                    SELECT Id, OrderApi__Is_Active__c, OrderApi__Expired_Date__c, OrderApi__Contact__c
                    FROM OrderApi__Badge__c
                    WHERE OrderApi__Contact__c IN :contactsIdToDeactivate
                    AND OrderApi__Badge_Type__c = :badgeTypeId
            ];

            for (OrderApi__Badge__c currBadge : relatedBadgesToDeactivate) {
                currBadge.OrderApi__Expired_Date__c = System.today() - 1;
                currBadge.OrderApi__Is_Active__c = false;
                contactIds.add(currBadge.OrderApi__Contact__c);
            }
            update relatedBadgesToDeactivate;

            if (contactIds.size() != 0) {
                return contactIds;
            }
        }
        return null;
    }

    public static void insertUpdateCGM(List<Contact> records, Map<Id, PagesApi__Community_Group_Member__c> contactToCgmMap,
            List<PagesApi__Community_Group_Member__c> comGroupMembersToCreate, List<Id> contactsIdToActive,
            List<Id> contactsIdToDeactivate, String Community_Group_Id, String checkbox){
        for (Contact currCon : records) {
            SObjectField checkboxField = Schema.getGlobalDescribe().get('Contact').getDescribe().fields.getMap().get(checkbox);
            if ((Boolean)currCon.get(checkboxField)) {
                if (!contactToCgmMap.containsKey(currCon.Id)) {
                    PagesApi__Community_Group_Member__c comGroupMem = new PagesApi__Community_Group_Member__c(
                            PagesApi__Contact__c = currCon.Id,PagesApi__Community_Group__c=Community_Group_Id,
                            PagesApi__Is_Active__c=true, PagesApi__Status__c = 'Active'
                    );
                    comGroupMembersToCreate.add(comGroupMem);
                    contactsIdToActive.add(currCon.Id);
                } else {
                    PagesApi__Community_Group_Member__c matchedCgm = contactToCgmMap.get(currCon.Id);
                    if (!matchedCgm.PagesApi__Is_Active__c) {
                        PagesApi__Community_Group_Member__c comGroupMem = new PagesApi__Community_Group_Member__c(
                                PagesApi__Contact__c = currCon.Id,PagesApi__Community_Group__c=Community_Group_Id,
                                PagesApi__Is_Active__c=true, PagesApi__Status__c = 'Active'
                        );
                        comGroupMembersToCreate.add(comGroupMem);
                        contactsIdToActive.add(currCon.Id);
                    }
                }
            } else {
                contactsIdToDeactivate.add(currCon.Id);
            }
        }
        if (comGroupMembersToCreate.size() != 0) {
            insert comGroupMembersToCreate;
        }
    }

    public static void createBadge(List<Id> contactsIdToActive, String BadgeTypeId){
        List<OrderApi__Badge__c> badgesToInsert = new List<OrderApi__Badge__c>();
        for (Id currContact : contactsIdToActive) {

            OrderApi__Badge__c cgmBadge = new OrderApi__Badge__c(
                    OrderApi__Contact__c = currContact,
                    OrderApi__Is_Active__c = true,
                    OrderApi__Awarded_Date__c = System.today(),
                    OrderApi__Badge_Type__c = BadgeTypeId
            );
            badgesToInsert.add(cgmBadge);

        }
        if (badgesToInsert.size() != 0) {
            insert badgesToInsert;
        }

    }
}