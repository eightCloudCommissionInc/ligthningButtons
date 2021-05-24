public class EC_QuickLinksController {
	
    @AuraEnabled(cacheable=true)
    public static List<Quick_Link__mdt> getQuickLinks(){
        List<Quick_Link__mdt> quickLink = new List<Quick_Link__mdt>();
        quickLink = [SELECT Id, MasterLabel, Link_For__c, URL__c, Sort_Order__c FROM Quick_Link__mdt WHERE Is_Active__c = true ORDER BY Sort_Order__c];
        return quickLink;
    }
    
}