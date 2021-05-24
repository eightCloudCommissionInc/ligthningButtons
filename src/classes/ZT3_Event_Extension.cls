/**
* @author Sujitha Nandigam
*/
public with sharing class ZT3_Event_Extension {
    
    public Map<String,string> keys;
    public List<EventApi__Attendee__c> attendees;
    public static void attendeeSync(EventApi__Event__c [] events){
        Map<String,String> keys = new Map<String,String>();
        Set<Id> attend =new Set<Id>();
        List<EventApi__Attendee__c>  attendees=new List<EventApi__Attendee__c>();
        Framework.Log.push(ZT3_Event_Extension.class.getName(),'createRegistrantinGTW');
        for(EventApi__Event__c a:events){
            if(a.Session_Key__c!=null){
                keys.put(a.Webinar_Key__c,a.Session_Key__c);
                attendees=[Select id,name, EventApi__Email__c, Join_Time__c, Leave_Time__c from EventApi__Attendee__c where EventApi__Attendee_Event__c=:a.id];
                for(EventApi__Attendee__c at:attendees){
                    attend.add(at.id);
                }
            }
            if(!System.isFuture() && !System.isBatch() && !System.isScheduled())
                asynchCallout(keys,attend); //call a method with @future annotation  
        }
        
    }
    
    @future(callout=true)
    Public static void asynchCallout(Map<String,String> keys,Set<Id> attIds){
        List<EventApi__Attendee__c> attendeeList=new List<EventApi__Attendee__c>();
        
        
        List<EventApi__Attendee__c> attendees=new List<EventApi__Attendee__c>();
        List<EventApi__Attendee__c> attees = [Select id,name, EventApi__Preferred_Email__c, Join_Time__c, Leave_Time__c from EventApi__Attendee__c where Id IN:attIds];
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
        
        for(String k:keys.keySet()){
            HttpRequest gtreq = new HttpRequest();
            
            string url='https://api.getgo.com/G2W/rest/v2/organizers/'+orgkey+'/webinars/'+k+'/sessions/'+keys.get(k)+'/attendees';
            gtreq.setEndpoint(url);
            gtreq.setMethod('GET'); 
            
            gtreq.setHeader('Authorization',''+accesstoken);
            gtreq.setHeader('Content-Type', 'application/json');
            
            Http gthttp = new Http();
            HTTPResponse gtres = gthttp.send(gtreq);
            
            system.debug('++Code'+gtres.getBody());
            
            List<Attendeedata> deserializedProductData=  new List<Attendeedata>();
            if(!Test.isRunningtest()) 
                deserializedProductData = (List<Attendeedata>)JSON.deserialize(gtres.getBody(), List<Attendeedata>.class);
            // Attendeedata obj = Attendeedata.parse(gtres.getBody());
            else
                deserializedProductData=(List<Attendeedata>)JSON.deserialize('[{"firstName":"Netsy","lastName":"Tefera","sessionKey":15931055,"attendanceTimeInSeconds":315,"registrantKey":8888438103327948813,"email":"ntefrea@zerotothree.org","attendance":[{"leaveTime":"2019-04-09T18:55:21Z","joinTime":"2019-04-09T18:50:06Z"}]},{"firstName":"HS Contact","lastName":"Test","sessionKey":15931055,"attendanceTimeInSeconds":184,"registrantKey":7116307933841429260,"email":"pdanduboina@zerotothree.org","attendance":[{"leaveTime":"2019-04-09T18:54:20Z","joinTime":"2019-04-09T18:51:16Z"}]}]',List<AttendeeData>.class);
            System.debug('#### productList ='+deserializedProductData);
            for(Attendeedata p : deserializedProductData){ 
                
                for(EventApi__Attendee__c a:attees){
                    if(p.email==a.EventApi__Preferred_Email__c){
                        Attendeedata.attendance subcls = new Attendeedata.attendance(); 
                        Subcls = p.attendance[0]; 
                        String myXstr = Subcls.joinTime; 
                        String myYstr = Subcls.leaveTime; 
                        
                        a.Join_Time__c=(DateTime)JSON.deserialize('"' + myXstr.removeEnd('Z') + '"', DateTime.class);
                        
                        System.debug('#### prod = '+a.Join_Time__c);
                        
                        a.leave_Time__c=(DateTime)JSON.deserialize('"' + myYstr.removeEnd('Z') + '"', DateTime.class);
                        a.attendanceTimeInMinutes__c=DateTime.valueOf(p.attendanceTimeInSeconds*1000).formatGMT('HH:mm:ss');
                        
                        attendeeList.add(a);
                        System.debug('#### prod = '+a);
                    }
                }
            }
        }
        if(attendeeList.size()>0)
            update attendeeList;
    }
    
}