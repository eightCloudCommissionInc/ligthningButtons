public class EC_AccountGroupsReportCtrl {
    
    public Map<id,Group__c> groupMap;
    public Map<string,List<account>> accGroupMap;
    public List<datawrapper> dwList{get;set;}
    
    public EC_AccountGroupsReportCtrl(){
        List<account> accList=[select id,cfg_Group_ID__c,GroupID2__c,GroupID3__c,GroupID4__c,GroupID5__c,
                               Name,npe01__One2OneContact__c,npe01__One2OneContact__r.Name,Type from Account where RecordType.Name IN ('HealthySteps Organization', 'HealthySteps Site', 'Potential HealthySteps') order by name limit 50000];
        
        List<account> orgAccList=new List<account>();
        List<account> HSAccList=new List<account>();
        List<account> potHSAccList=new List<account>();
        List<account> blankAccList=new List<account>();
        for(Account acc:accList){
            if(acc.Type=='HS Organization')orgAccList.add(acc);
            if(acc.Type=='HS Site')HSAccList.add(acc);
            if(acc.Type=='Potential HS Site')potHSAccList.add(acc);
            if(acc.Type==null||acc.Type=='')blankAccList.add(acc);
        }
        List<account> sortedAccList=new List<account>();
        sortedAccList.addall(orgAccList);
        sortedAccList.addall(HSAccList);
        sortedAccList.addall(potHSAccList);
        sortedAccList.addall(blankAccList);
        
        set<string> groupSet=new set<string>();
        
        groupMap=new Map<id,Group__c>([select id,Name,cfg_Description__c,CFG_Type__c,createdbyId,
                                       createdby.Name,lastmodifiedbyId,lastmodifiedby.Name,ownerId,owner.Name  from Group__c order by Name asc ]);
        
        accGroupMap=new Map<string,List<account>>();
        for(Account acc:sortedAccList){
            if(acc.cfg_Group_ID__c!=null){
                if(accGroupMap.containskey(acc.cfg_Group_ID__c)){
                    accGroupMap.get(acc.cfg_Group_ID__c).add(acc);
                }else{
                    accGroupMap.put(acc.cfg_Group_ID__c,new List<account>{acc});
                }
            }
            if(acc.GroupID2__c!=null){
                if(accGroupMap.containskey(acc.GroupID2__c)){
                    accGroupMap.get(acc.GroupID2__c).add(acc);
                }else{
                    accGroupMap.put(acc.GroupID2__c,new List<account>{acc});
                }
            }
            if(acc.GroupID3__c!=null){
                if(accGroupMap.containskey(acc.GroupID3__c)){
                    accGroupMap.get(acc.GroupID3__c).add(acc);
                }else{
                    accGroupMap.put(acc.GroupID3__c,new List<account>{acc});
                }
            }
            if(acc.GroupID4__c!=null){
                if(accGroupMap.containskey(acc.GroupID4__c)){
                    accGroupMap.get(acc.GroupID4__c).add(acc);
                }else{
                    accGroupMap.put(acc.GroupID4__c,new List<account>{acc});
                }
            }
            if(acc.GroupID5__c!=null){
                if(accGroupMap.containskey(acc.GroupID5__c)){
                    accGroupMap.get(acc.GroupID5__c).add(acc);
                }else{
                    accGroupMap.put(acc.GroupID5__c,new List<account>{acc});
                }
            }
            
        }
        
        set<string> orderedGroupSet=new set<string>();
        for(id id: groupMap.keyset()){
            if(accGroupMap.containskey(id)){
                orderedGroupSet.add(id);
            }
        }
        
        dwList=new List<datawrapper>();
        for(string str : orderedGroupSet){


            for(account acc:accGroupMap.get(str)){
                dataWrapper dw=new dataWrapper();
                dw.size=accGroupMap.get(str).size();
                dw.groupNo=groupMap.get(str).Name;
                dw.groupId=groupMap.get(str).Id;
                dw.accName=acc.Name;
                dw.accId=acc.Id;
                dw.primaryContact=acc.npe01__One2OneContact__c!=null?acc.npe01__One2OneContact__r.Name:null;
                dw.primaryContactId=acc.npe01__One2OneContact__c!=null?acc.npe01__One2OneContact__c:null;
                dw.accType=acc.Type;
                dw.groupType=groupMap.get(str).CFG_Type__c;
                dw.Description=groupMap.get(str).cfg_Description__c;
                dw.createdBy=groupMap.get(str).createdby.Name;
                dw.lastModifiedBy=groupMap.get(str).Lastmodifiedby.Name;
                dw.owner=groupMap.get(str).Owner.Name;
                dw.createdById=groupMap.get(str).createdbyId;
                dw.lastModifiedById=groupMap.get(str).LastmodifiedbyId;
                dw.ownerId=groupMap.get(str).OwnerId;
                dwList.add(dw);
            }
        }
    
    }
    
    public class dataWrapper{
        public string groupNo{get;set;}
        public string groupId{get;set;}
        public string accName{get;set;}
        public string accId{get;set;}
        public string primaryContact{get;set;}
        public string primaryContactId{get;set;}
        public string accType{get;set;}
        public string groupType{get;set;}
        public string Description{get;set;}
        public string createdBy{get;set;}
        public string createdById{get;set;}
        public string lastModifiedBy{get;set;}
        public string lastModifiedById{get;set;}
        public string owner{get;set;}
        public string ownerId{get;set;}
        public integer size{get;set;}
    }

}