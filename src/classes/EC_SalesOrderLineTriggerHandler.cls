public class EC_SalesOrderLineTriggerHandler {
    
    public static void after(List<OrderApi__Sales_Order_Line__c> triggerNew){
        //get salesorder & related contqact
        //
        set<id> salesOrderSet=new set<id>();
        for(OrderApi__Sales_Order_Line__c sol: triggerNew){
            salesOrderSet.add(sol.OrderApi__Sales_Order__c);
        }
        set<id> contactSet=new set<id>();
        for(OrderApi__Sales_Order__c so: [select id, OrderApi__Contact__c  from OrderApi__Sales_Order__c where id in:salesOrderSet ]){
            contactSet.add(so.OrderApi__Contact__c);
        }
        
        processData(contactSet);
    }
    
    
    public static void processData(set<id> contactSet){
        
        
        
        List<OrderApi__Sales_Order_Line__c> solList=[select id, OrderApi__Sales_Order__r.OrderApi__Contact__c,OrderApi__Sales_Order__c,
                                                     OrderApi__Sales_Order__r.OrderApi__Contact__r.Bookstore_Purchase_Year__c ,
                                                     OrderApi__Sales_Order__r.OrderApi__Contact__r.Number_of_Items_Purchased__c  ,
                                                     OrderApi__Sales_Order__r.OrderApi__Posted_Date__c ,OrderApi__Item_Class__c,OrderApi__Item_Class__r.Name ,OrderApi__Is_Posted__c 
                                                     from OrderApi__Sales_Order_Line__c where OrderApi__Sales_Order__r.OrderApi__Contact__c in :contactSet and OrderApi__Is_Posted__c = true];
        
        
        Map<Id,List<OrderApi__Sales_Order_Line__c>> contactSolMap=new Map<Id,List<OrderApi__Sales_Order_Line__c>>();
        
        
        for(OrderApi__Sales_Order_Line__c sol:solList){
            
            
            //create contact- sales order line map
            if(contactSolMap.containsKey(sol.OrderApi__Sales_Order__r.OrderApi__Contact__c)){
                contactSolMap.get(sol.OrderApi__Sales_Order__r.OrderApi__Contact__c).add(sol);
            }else{
                contactSolMap.put(sol.OrderApi__Sales_Order__r.OrderApi__Contact__c,new List<OrderApi__Sales_Order_Line__c>{sol});
            }
            
            
        }
        
        
        /*
* 
*1. Any time a physical or digital item has been purchased, update the Bookstore_purchase_year c (multi-select picklist) field with the sales order’s posted date year.
• IF a new Sales Order record is created AND {
o OrderApi__Item_Class__c (from the OrderApi__Sales_Order_Line__c) contains “Merchandise” AND
o the OrderApi__Is_Posted__c checkbox is true AND
o the Bookstore_purchase_year is null OR the the Bookstore_purchase_year value is not equal to today’s year OrderApi__Posted_Date__c
• Update the Bookstore_purchase_year c (multi-select picklist) field with the sales order’s posted date year ( OrderApi__Posted_Date__c )

*/
        
        Map<Id, set<String>> contactYearStringMap=new Map<Id, set<String>>();
        for(id id: contactSolMap.keyset()){
            set<string> yearSet=new set<string>();
            for(OrderApi__Sales_Order_Line__c sol: contactSolMap.get(id)){
                if(sol.OrderApi__Item_Class__c!=null && sol.OrderApi__Item_Class__r.Name.contains('Merchandise')){
                    //flag this contact to store the order- posted date year
                    if(sol.OrderApi__Sales_Order__r.OrderApi__Posted_Date__c!=null){
                        string year = string.valueof(sol.OrderApi__Sales_Order__r.OrderApi__Posted_Date__c.year());
                        yearSet.add(year);
                        
                        
                    }
                }
            }
            
            if(!yearSet.isEmpty())contactYearStringMap.put(id,yearSet); //contact id  year set map
            
        }
        
        /*
* 2. Count and display the total number of items an individual buys from the bookstore
• IF a new Sales Order record is created AND {
o OrderApi__Item_Class__c (from the OrderApi__Sales_Order_Line__c) contains “Merchandise” AND
o OrderApi__Item_Class__c does not contain: “Shipping fees” AND
o the OrderApi__Is_Posted__c checkbox is true
• COUNT number of sales order lines (OrderApi__Sales_Order_Line__c ) that match the criteria above AND
• ADD that number to the total number of Number_of_items_purchased__c (number) field
*/
        
        Map<Id, Integer> contactItemCountMap=new Map<Id, Integer>();
        for(id id: contactSolMap.keyset()){
            integer count= 0;
            for(OrderApi__Sales_Order_Line__c sol: contactSolMap.get(id)){
                if(sol.OrderApi__Item_Class__c!=null && sol.OrderApi__Item_Class__r.Name.contains('Merchandise') && !sol.OrderApi__Item_Class__r.Name.contains('Shipping fees')){
                    //flag this contact to store the order- posted date year
                    count++; //increment the count
                    
                }
            }
            contactItemCountMap.put(id,count); //contact id count map
        }
        
        
        //create contact List & update
        List<contact> contactsToUpdate=new List<contact>();
        for(id id: contactSet){
            Contact c=new Contact(id=Id);
            if(contactItemCountMap.containskey(Id)||contactYearStringMap.containskey(id)){
                
                if(contactYearStringMap.containskey(Id)){
                    List<string> yearList=new List<string>(contactYearStringMap.get(Id));
                    c.Bookstore_Purchase_Year__c=string.Join(yearList,';');
                }else{
                    c.Bookstore_Purchase_Year__c=null;
                }
                if(contactItemCountMap.containskey(id)){
                    c.Number_of_Items_Purchased__c = contactItemCountMap.get(id);
                }
                
            }else{
                c.Bookstore_Purchase_Year__c=null;
                c.Number_of_Items_Purchased__c =0;
            }
            contactsToUpdate.add(c);
        }
        
        if(!contactsToUpdate.isEmpty()) update contactsToUpdate;
        
    }
}