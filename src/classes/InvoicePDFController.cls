public class InvoicePDFController {
	
    @AuraEnabled
    public static ContentVersion previewPDF(Id contactId) {
        Date forDate = Date.today().toStartOfMonth();
        ContentVersion cv = new ContentVersion();
        try {
            cv = InvoiceEmailSender.SavePDF(contactId, forDate);
        } catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
        
        return cv;
    }
    
    @AuraEnabled
    public static void sendPDF(Id contactId) {
        Date forDate = Date.today().toStartOfMonth();
        try {
            InvoiceEmailSender.SendPDF(contactId, forDate);
        } catch (Exception ex) {
            throw new AuraHandledException(ex.getMessage());
        }
    }
    
}