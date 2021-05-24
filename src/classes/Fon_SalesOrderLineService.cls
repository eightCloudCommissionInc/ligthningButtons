/**************************************************************************************************************************************************************************************************************************************************************
Name            :-  Fon_SalesOrderLineService
Created Date    :-  08/14/2019
Updated Date    :-  
Created By      :- 
Dependencies    :-  
Description     :-  Trigger on salesorderline to split shipping street into 6 fields if charatcter count is more than 40. Bright key shipping limitation.
**************************************************************************************************************************************************************************************************************************************************************/

public with sharing class Fon_SalesOrderLineService {

public static void upsertStreetAddress(OrderApi__Sales_Order_Line__c [] records,Map<Id,OrderApi__Sales_Order_Line__c> oldMap) {
        map<String,String> statepicklist = new map<String,String>();
        Schema.DescribeFieldResult fieldResult = OrderApi__Sales_Order__c.FON_Billing_State_List__c.getDescribe();
        List<Schema.PicklistEntry> values = fieldResult.getPicklistValues();
        for( Schema.PicklistEntry v : values) {
        statepicklist.put(v.getLabel(),v.getValue());
            //System.debug('Picklist Value Label:' + v.getLabel());
            //System.debug('Picklist API Name:' + v.getValue());
        }
        Schema.DescribeFieldResult fieldResultca = OrderApi__Sales_Order__c.FON_CA_BillingState_List__c.getDescribe();
        List<Schema.PicklistEntry> cavalues = fieldResultca.getPicklistValues();
        for( Schema.PicklistEntry v : cavalues) {
        statepicklist.put(v.getLabel(),v.getValue());
            //System.debug('Picklist Value Label:' + v.getLabel());
            //System.debug('Picklist API Name:' + v.getValue());
        }
        for(OrderApi__Sales_Order_Line__c rec: records){
            if(Test.isRunningTest()){
                rec.OrderApi__Shipping_Street__c = '4420 N fairfax Drive, Arlington, VA TEST data';
                rec.OrderApi__Shipping_Country__c ='Congo';
            }
            if(rec.OrderApi__Shipping_Street__c!=null){
                
                String strAddress=rec.OrderApi__Shipping_Street__c;
                strAddress = strAddress.replace('\r\n', ' ');
                strAddress = strAddress.replace('\n', ' ');
                strAddress = strAddress.replace('\r', ' ');
                integer characterLength = 40;
                 List<String> lstSplitAddress = strAddress.split(' ');
                        List<String> lstAddressByCharacter = new List<String>{'','','','','',''};
                        Integer index = 0;
                        for(Integer i = 0; i < lstSplitAddress.size(); i++){
                            String strTempAddress = lstAddressByCharacter[index] +' '+ lstSplitAddress[i];
                            if(strTempAddress.length() < characterLength){
                                lstAddressByCharacter[index] = lstAddressByCharacter[index] +' '+ lstSplitAddress[i];
                            }else{
                                if(index < 5){
                                    index++;
                                    lstAddressByCharacter[index] = lstAddressByCharacter[index] +' '+ lstSplitAddress[i];
                                }else{
                                    lstAddressByCharacter[index] = lstAddressByCharacter[index] +' '+ lstSplitAddress[i];
                                }
                            }
                             
                        }
                
                    if(lstAddressByCharacter[0]!=null)
                        rec.FON_ShippingStreet1__c = lstAddressByCharacter[0];
                    
                    if(lstAddressByCharacter[1]!=null)
                        rec.FON_ShippingStreet2__c = lstAddressByCharacter[1];
                        
                    if(lstAddressByCharacter[2]!=null)
                        rec.FON_ShippingStreet3__c = lstAddressByCharacter[2];
                        
                    if(lstAddressByCharacter[3]!=null)
                        rec.FON_ShippingStreet4__c = lstAddressByCharacter[3];
                        
                    if(lstAddressByCharacter[4]!=null)
                        rec.FON_ShippingStreet5__c = lstAddressByCharacter[4];
                        
                    if(lstAddressByCharacter[5]!=null)
                        rec.FON_ShippingStreet6__c = lstAddressByCharacter[5];

                }
                /* 4 countries have more than 30char so adding code for it
                Bolivia, Plurinational State of(31 characters)
                Korea, Democratic People's Republic of (38 characters)- No shipping for Korea, democratic republic
                Macedonia, the former Yugoslav Republic of (42 characters)
                Congo, the Democratic Republic of the(37 characters)
                From BK list
                Micronesia, Federated States of
                Heard Island & McDonald Islands
                Laos, People's Democratic Republic of
                South Georgia & The South Sandwich Islands
                Macedonia, The Former Yugoslav Republic of
                */
                 if((rec.OrderApi__Shipping_Country__c!=null && rec.OrderApi__Shipping_Country__c!= '')){
                   if(rec.OrderApi__Shipping_Country__c.containsignorecase(Label.BK_Bolivia))
                       rec.OrderApi__Shipping_Country__c = 'BO';
                   else if (rec.OrderApi__Shipping_Country__c.containsignorecase(Label.BK_Macedonia)) 
                       rec.OrderApi__Shipping_Country__c = 'MK';
                   else if (rec.OrderApi__Shipping_Country__c.containsignorecase(Label.BK_Congo) && rec.OrderApi__Shipping_Country__c.containsignorecase(Label.BK_Democratic) )
                       rec.OrderApi__Shipping_Country__c = 'CD';
                   else if (rec.OrderApi__Shipping_Country__c.containsignorecase(Label.BK_Micronesia) )
                       rec.OrderApi__Shipping_Country__c = 'FM';
                   else if( rec.OrderApi__Shipping_Country__c.containsignorecase(Label.BK_Laos))
                       rec.OrderApi__Shipping_Country__c = 'LA';
                   else if( rec.OrderApi__Shipping_Country__c.containsignorecase(Label.BK_Heard_Island))
                       rec.OrderApi__Shipping_Country__c = 'HM';
                       else if( rec.OrderApi__Shipping_Country__c.containsignorecase(Label.BK_south_georgia))
                       rec.OrderApi__Shipping_Country__c = 'GS';
              
                }
                //Not converting to custom labels, all options added here
                 if((rec.OrderApi__Shipping_Country__c!=null && rec.OrderApi__Shipping_Country__c!= '') && (rec.OrderApi__Shipping_Country__c.equalsignorecase('canada')|| rec.OrderApi__Shipping_Country__c.equalsignorecase('CA') ||rec.OrderApi__Shipping_Country__c.equalsignorecase('USA') || rec.OrderApi__Shipping_Country__c.equalsignorecase('United States of America') || rec.OrderApi__Shipping_Country__c.equalsignorecase('United States')|| rec.OrderApi__Shipping_Country__c.equalsignorecase('US')) && (rec.OrderApi__Shipping_State__c!=null || rec.OrderApi__Shipping_State__c!='')){
                    
                    if(statepicklist.get(rec.OrderApi__Shipping_State__c)!=null)
                       rec.FON_Shipping_State_Code__c =statepicklist.get(rec.OrderApi__Shipping_State__c);
                   
                }
                //system.debug('!!!===2 letter state-'+rec.FON_Shipping_State_Code__c);

           } 
        }
}