/**
* @author Sujitha Nandigam
*/
public with sharing class ZT3_Attendee_Extension {
    
    public List<String> keys;
    public Map<Id,String> attendMap;
    
    public static void createRegistrantinGTW(EventApi__Attendee__c [] attendees){
        List<String> keys = new List<String>();
        Map<Id,String> attendMap =new Map<Id,String>();
        Framework.Log.push(ZT3_Attendee_Extension.class.getName(),'createRegistrantinGTW');
        for(EventApi__Attendee__c a:attendees){
            if(a.Event_Webinar_Key__c!=null ){
                //keys.add(a.Event_Webinar_Key__c);
                attendMap.put(a.id,a.Event_Webinar_Key__c);
                
            }
            else if(a.Event_Webinar_Key__c!=null){
                                attendMap.put(a.id,a.Event_Webinar_Key__c);

            } 
            
                 
        }
        if(!System.isFuture() && !System.isBatch() && !System.isScheduled())
            asynchCallout(attendMap.values(),attendMap.keySet()); //call a method with @future annotation  
    }
    
    
    @future(callout=true)
    Public static void asynchCallout(List<String> keys,Set<Id> attIds){
        List<EventApi__Attendee__c> attendees=new List<EventApi__Attendee__c>();
        List<EventApi__Attendee__c> attees = [Select id,name,Event_Webinar_Key__c, Attendee_LastName__c, Attendee_FirstName__c, EventApi__Preferred_Email__c, Join_Time__c, Leave_Time__c from EventApi__Attendee__c where Id IN:attIds];
        List<EventApi__Attendee__c> attList=new List<EventApi__Attendee__c>();

        HttpRequest req = new HttpRequest();
        
        req.setEndpoint('https://api.getgo.com/oauth/v2/token?grant_type=password&username=Remotemeeting@zerotothree.org&password=4zttremote!');
        req.setMethod('POST'); 
        req.setHeader('Authorization', 'Basic VmtGbWVBWXg4SUdPaE5DR2hHMG1XY1ZJSno5aHNRVVg6akxkZFFoS3JlZG9SQ0FzTg==');
        req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
        req.setHeader('cache-control','no-cache');
        req.setHeader('Accept', 'application/json');
        
        
        Http http = new Http();
        HTTPResponse res = http.send(req);
        
        // string accesstoken=new JSONObject(res.getBody()).getValue('access_token').str;
        // string orgkey= new JSONObject(res.getBody()).getValue('organizer_key').str;
        JSON2ApexAccessToken JS = new JSON2ApexAccessToken ();
        //JSON method to bind response into a wrapper class.
        JS = (JSON2ApexAccessToken)JSON.deserialize(res.getbody(),JSON2ApexAccessToken.class);
        string accesstoken = JS.access_token;
        string orgkey= JS.organizer_key;
        
        for(EventApi__Attendee__c at:attees){
            HttpRequest gtreq = new HttpRequest();
            string b='{"firstName": "'+at.Attendee_FirstName__c+'", "lastName": "'+at.Attendee_LastName__c+'","email": "'+at.EventApi__Preferred_Email__c+'"}';
            
            string url='https://api.getgo.com/G2W/rest/v2/organizers/'+orgkey+'/webinars/'+at.Event_Webinar_Key__c+'/registrants';
            gtreq.setEndpoint(url);
            gtreq.setMethod('POST'); 
            
            if(!Test.isRunningTest()){
                gtreq.setHeader('Authorization', accesstoken);
                gtreq.setHeader('Content-Type', 'application/json;charset=UTF-8');
                //gtreq.setHeader('cache-control','no-cache');
                gtreq.setHeader('Accept', 'application/vnd.citrix.g2wapi-v1.1+json');
                gtreq.setBody(b);                           
                
                Http gthttp = new Http();
                HTTPResponse gtres = gthttp.send(gtreq);
                
                system.debug('++Code'+gtres.getBody());
                
                if(gtres.getStatusCode()==201)
                
 
                   at.GTW_callout__c ='Success';
                   else
                 
                   at.GTW_callout__c ='Failed';
               at.GTW_response__c=String.ValueOf(gtres.getStatusCode());
                   attList.add(at);
                
                
            }
        }
        
        if(!attList.isEmpty())
        update attList;
    }
    
    
    public static void createRegistrantinGTWUpdate(EventApi__Attendee__c [] attendees,Map<Id,EventApi__Attendee__c> oldMap){
        List<String> keys = new List<String>();
        Map<Id,String> attendMap =new Map<Id,String>();
        
        Framework.Log.push(ZT3_Attendee_Extension.class.getName(),'createRegistrantinGTW');
        for(EventApi__Attendee__c a:attendees){
           
            if(a.Event_Webinar_Key__c!=null && oldMap.get(a.Id).GTW_response__c==a.GTW_response__c && a.GTW_response__c==null ){
               attendMap.put(a.id,a.Event_Webinar_Key__c);
            } 
            
                 
        }
        if(!System.isFuture() && !System.isBatch() && !System.isScheduled())
            asynchCallout(attendMap.values(),attendMap.keySet()); //call a method with @future annotation  
    }
}