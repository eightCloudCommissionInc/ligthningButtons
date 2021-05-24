public class Fon_PushGTMCodeApex {
    @AuraEnabled
    public static string getOrderProducts(String soId){
        string finalJSON = '';
        List<SO_JSON2Apex> SOJSONs = new list<SO_JSON2Apex>();
        List<SO_JSON2Apex.TransactionProducts> allSOLs = new List<SO_JSON2Apex.TransactionProducts>();
        Set<Id> salesorderIds = new Set<Id>();
        //String soId='/ZT3StagingCommunity/apex/lte__receiptinvoice?id=a3Q2f000000GiTzEAK&name=0000055837';
        
        SO_JSON2Apex SOJSON = new SO_JSON2Apex();
        if(soId != null){
            /*Integer i = soId.indexOf('id=');

Integer j = soId.indexOf('&',i);

system.debug('final'+soId.substring(i,j));
String receiptId =soId.substring(i,j);*/
            system.debug('!!!!!='+soId);
            OrderApi__Receipt__c rec = [select id,name,product_url__c,OrderApi__Sales_Order__c from OrderApi__Receipt__c where name =:soId];
            //salesorderIds.add(soId); 
            SOJSON.productUrl = rec.product_url__c;
              system.debug('------rec='+rec);
              system.debug('------SOJSON.productUrl..!='+SOJSON.productUrl);
            If(rec.OrderApi__Sales_Order__c !=null)  {         
                for(OrderApi__Sales_Order__c SO:[select id,name,OrderApi__Account__r.Name,OrderApi__Total__c,(select id,name, OrderApi__Item__r.name,OrderApi__Sale_Price__c, OrderApi__Quantity__c,OrderApi__Item_Class__r.Name from OrderApi__Sales_Order_Lines__r) from OrderApi__Sales_Order__c where id =:rec.OrderApi__Sales_Order__c]){
                    allSOLs = new List<SO_JSON2Apex.TransactionProducts>();
                    system.debug('------!!!!!='+soId);
                    
                    SOJSON.transactionId = SO.id;
                    SOJSON.transactionAffiliation = SO.OrderApi__Account__r.Name;
                    SOJSON.transactionTotal = SO.OrderApi__Total__c;
                    SOJSON.transactionTax = SO.OrderApi__Total__c;
                    //SOJSON.transactionShipping = (Integer)SO.OrderApi__Item_Count__c;               
                    for(OrderApi__Sales_Order_Line__c SOL : SO.OrderApi__Sales_Order_Lines__r){
                        SO_JSON2Apex.TransactionProducts SOLJSON = new SO_JSON2Apex.TransactionProducts();
                        SOLJSON.sku = SOL.Name;
                        SOLJSON.name = SOL.OrderApi__Item__r.name;
                        SOLJSON.category = SOL.OrderApi__Item_Class__r.Name;
                        SOLJSON.price = SOL.OrderApi__Sale_Price__c;
                        SOLJSON.quantity = (Integer)SOL.OrderApi__Quantity__c;
                        allSOLs.add(SOLJSON);
                    }
                    SOJSON.transactionProducts = allSOLs;
                    SOJSONs.add(SOJSON);
                    system.debug('!!!!!='+SOJSON);
                }
            }
        }   
        if(SOJSONs.size()>0){
            system.debug('!!!!!='+SOJSONs);
            finalJSON = json.serialize(SOJSONs);
            return finalJSON; 
        }
        return null;
    }
    
    
    
    public void throwError(List<OrderApi__Sales_Order__c> salesOrderList){
        
    }
}