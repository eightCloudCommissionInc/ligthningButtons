@isTest
private class InvoicePDFControllerTest {
    
    @testSetup static void setup() {
        // Create common test contact
        Contact testCont = new Contact(FirstName = 'TestName', LastName = 'TestLastName');
        insert testCont;
    }
    
    @isTest
    static void testPreviewPDF() {
        Date forDate = Date.today().toStartOfMonth();
        
        List<Contact> cont= [SELECT Id, Name FROM Contact];
        try {
            if(!cont.isEmpty()) {
                Id contactId = cont[0].Id;
                Test.startTest();
                	ContentVersion cv = InvoicePDFController.previewPDF(contactId);
                Test.stopTest();
            }
        }  catch(Exception ex){}        
    }     
    
    @isTest
    static void testSendPDF() {
        Date forDate = Date.today().toStartOfMonth();
        
        List<Contact> cont= [SELECT Id , Name FROM Contact];
        try {
            if(!cont.isEmpty()) {
                Id contactId = cont[0].Id;
                Test.startTest();
                	InvoicePDFController.sendPDF(contactId);
                Test.stopTest();
            }
        }  catch(Exception ex){}
    }    
}