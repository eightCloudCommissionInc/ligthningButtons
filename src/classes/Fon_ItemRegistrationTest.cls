@isTest
public class Fon_ItemRegistrationTest implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        return response;
    }
    @testSetup
    static void testSetup() {
        
        Account acc = new Account();
        acc.name='Test';
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'Test';
        con.firstName ='test';
        con.AccountId = acc.id;
        insert con; 
        
        
        OrderApi__Receipt__c recepit = new OrderApi__Receipt__c();
        recepit.OrderApi__Account__c = acc.id;
        recepit.OrderApi__Contact__c = con.id;
        insert recepit;
        
        OrderApi__Item_Class__c itemClass = new OrderApi__Item_Class__c();
        itemClass.Name= 'Test';  
        itemClass.OrderApi__Is_Active__c = true;
        insert itemClass;
        
        OrderApi__item__c item = new OrderApi__item__c();
        item.Name ='fee';
        item.OrderApi__Display_Name__c ='fee';
        item.OrderApi__Item_Class__c = itemClass.id;
        item.OrderApi__Is_Active__c = true;
        insert item;
        
        OrderApi__Item_Class__c itemClass2 = new OrderApi__Item_Class__c();
        itemClass2.Name= 'LMS Courses';  
        itemClass2.OrderApi__Is_Active__c = true;
        insert itemClass2;
        
        OrderApi__item__c item2 = new OrderApi__item__c();
        item2.Name ='fee1';
        item2.OrderApi__Display_Name__c ='fee';
        item2.OrderApi__Item_Class__c = itemClass2.id;
        item2.OrderApi__Is_Active__c = true;
        insert item2;
        
        OrderApi__Receipt_Line__c recepitLine =new OrderApi__Receipt_Line__c();
        recepitLine.OrderApi__Receipt__c = recepit.Id;
        recepitLine.OrderApi__Contact__c = con.Id;
        recepitLine.OrderApi__Item__c = item.id;   
        insert recepitLine;
        
        OrderApi__Receipt_Line__c recepitLine2 =new OrderApi__Receipt_Line__c();
        recepitLine2.OrderApi__Receipt__c = recepit.Id;
        recepitLine2.OrderApi__Contact__c = con.Id;
        recepitLine2.OrderApi__Item__c = item2.id;   
        insert recepitLine2;
        
    }        
    static testMethod void method1(){ 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Fon_ItemRegistrationTest()); 
        List<OrderApi__Receipt_Line__c> recepitLineLst = new List<OrderApi__Receipt_Line__c>();
        OrderApi__Item_Class__c itmClass =[Select id,Name,OrderApi__Is_Active__c from OrderApi__Item_Class__c limit 1];
        OrderApi__item__c itm =[Select id,Name,OrderApi__Is_Active__c from OrderApi__item__c limit 1];
        OrderApi__Receipt_Line__c receiptLine = [Select id,OrderApi__Item__r.Name,OrderApi__Receipt__r.OrderApi__Contact__c from OrderApi__Receipt_Line__c limit 1];
        recepitLineLst.add(receiptLine);
        Fon_RecepitLineTrigger.Constructor attCunstruct = new Fon_RecepitLineTrigger.Constructor();
        attCunstruct.construct(recepitLineLst);
        Fon_RecepitLineTrigger recTrigger = new Fon_RecepitLineTrigger(recepitLineLst);
        recTrigger.afterInsert();

        string recepitLinejson = 'Test';
        try{           
            Fon_ItemRegistrationWrapper.parse(recepitLinejson);
            Fon_ItemRegistrationResponseWrapper.parse(recepitLinejson);
            SO_JSON2Apex.parse(recepitLinejson);
        }catch(exception e){
            
        }
        Test.stopTest();
    }    
    
    static testMethod void method2(){ 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Fon_ItemRegistrationTest()); 
        List<OrderApi__Receipt_Line__c> recepitLineLst = new List<OrderApi__Receipt_Line__c>();
        OrderApi__Item_Class__c itmClass =[Select id,Name,OrderApi__Is_Active__c from OrderApi__Item_Class__c where name='LMS Courses'];
        OrderApi__item__c itm =[Select id,Name,OrderApi__Is_Active__c from OrderApi__item__c where name='fee1'];
        OrderApi__Receipt_Line__c receiptLine = [Select id,OrderApi__Item__r.Name,OrderApi__Receipt__r.OrderApi__Contact__c from OrderApi__Receipt_Line__c where OrderApi__Item__r.Name='fee1'];
        recepitLineLst.add(receiptLine);
        Fon_RecepitLineTrigger.Constructor attCunstruct = new Fon_RecepitLineTrigger.Constructor();
        attCunstruct.construct(recepitLineLst);
        Fon_RecepitLineTrigger recTrigger = new Fon_RecepitLineTrigger(recepitLineLst);
        recTrigger.afterInsert();

        string recepitLinejson = 'Test';
        try{           
            Fon_ItemRegistrationWrapper.parse(recepitLinejson);
        }catch(exception e){
            
        }
        Test.stopTest();
    }    
    
    /*static testMethod void method3(){ 
        Test.startTest();
        Test.setMock(HttpCalloutMock.class, new Fon_ItemRegistrationTest()); 
        List<OrderApi__Receipt_Line__c> recepitLineLst = new List<OrderApi__Receipt_Line__c>();
        OrderApi__Item_Class__c itmClass =[Select id,Name,OrderApi__Is_Active__c from OrderApi__Item_Class__c limit 1];
        OrderApi__item__c itm =[Select id,Name,OrderApi__Is_Active__c from OrderApi__item__c limit 1];
        OrderApi__Receipt_Line__c receiptLine = [Select id,OrderApi__Item__r.Name,OrderApi__Receipt__r.OrderApi__Contact__c from OrderApi__Receipt_Line__c limit 1];
        recepitLineLst.add(receiptLine);
        Fon_RecepitLineTrigger.Constructor attCunstruct = new Fon_RecepitLineTrigger.Constructor();
        attCunstruct.construct(recepitLineLst);
        Fon_RecepitLineTrigger recTrigger = new Fon_RecepitLineTrigger(recepitLineLst);
        recTrigger.afterInsert();

        string recepitLinejson = 'Test';
        try{           
            Fon_ItemRegistrationWrapper.parse(recepitLinejson);
        }catch(exception e){
            
        }
        Test.stopTest();
    } */   
    
    
}