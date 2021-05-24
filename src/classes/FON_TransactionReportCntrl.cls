public without sharing class FON_TransactionReportCntrl{
    
    public string type {get; set;}
    public string frmDate {get; set;}
    public string toDate {get; set;}
    public List<OrderApi__GL_Account__c> lstGLAcc {get; set;}
    public List<OrderApi__Transaction__c> lstTran {get; set;}
    public List<OrderApi__Transaction_Line__c> lstTranLine {get; set;}
    public Map<String, List<OrderApi__Transaction_Line__c>> mapGLTL {get; set;}
    public Map<Date, List<OrderApi__Transaction_Line__c>> mapDtTL {get; set;}
    public List<Date> dates {get; set;}
    public List<String> vals {get; set;}
    public List<ReportWrapper> lstReportdata {get;set;}
    public List<OrderApi__Transaction_Line__c> updateLst {get; set;}
    
    public String xlsHeader {
        get {
            String strHeader = '';
            strHeader += '<?xml version="1.0"?>';
            strHeader += '<?mso-application progid="Excel.Sheet"?>';
            
            return strHeader;
        }
    }
    
    public FON_TransactionReportCntrl(){
        
    }
    
    public void pageAction(){
        
        //type = ApexPages.currentPage().getParameters().get('type');
        frmDate = ApexPages.currentPage().getParameters().get('fDate');
        toDate = ApexPages.currentPage().getParameters().get('tDate');
        
        Date fDate = Date.valueOf(frmDate); 
        Date tDate = Date.valueOf(toDate);             
        
        //Date fDate = Date.valueOf('2019-04-01'); 
        //Date tDate = Date.valueOf('2019-04-02');             
        
        updateLst = new List<OrderApi__Transaction_Line__c>();
        
        // saving GL account with tranaction lines based upon the created date
        map<string,map<date,List<OrderApi__Transaction_Line__c>>> mapAccount_TransactionLine = new map<string,map<date,List<OrderApi__Transaction_Line__c>>>();
        
        // getting list of transaction lines based upon the date range and type
        lstTranLine = new List<OrderApi__Transaction_Line__c>();
        lstTranLine = [SELECT Id,
                       Name,
                       FON_Account_Number__c,
                       FON_Project_Number__c,
                       FON_Posted_In_Navision__c,
                       OrderApi__Date__c,
                       OrderApi__Credit__c,
                       OrderApi__Debit__c,
                       FON_Difference_Amount__c,
                       OrderApi__Transaction__c,
                       OrderApi__Transaction__r.OrderApi__Date__c,
                       OrderApi__Transaction__r.CreatedDate,
                       OrderApi__Transaction__r.OrderApi__Type__c                             
                       FROM OrderApi__Transaction_Line__c
                       WHERE OrderApi__Transaction__r.OrderApi__Date__c >= :fDate 
                       AND OrderApi__Transaction__r.OrderApi__Date__c <= :tDate 
                       AND FON_Posted_In_Navision__c = FALSE
                       And FON_Difference_Amount__c !=0  //For reduced data in query  6 sept 2019
                       
                      ];
        
        for(OrderApi__Transaction_Line__c TL : lstTranLine){
            
            // checking if the account exist in the map
            if(mapAccount_TransactionLine.containsKey(TL.FON_Account_Number__c+'@'+TL.FON_Project_Number__c)){
                
                // getting map for the account
                map<date,List<OrderApi__Transaction_Line__c>> mapGLAccDetails = mapAccount_TransactionLine.get(TL.FON_Account_Number__c+'@'+TL.FON_Project_Number__c);
                
                // checking if we have record with same date
                if(mapGLAccDetails.containsKey(TL.OrderApi__Date__c)){
                    List<OrderApi__Transaction_Line__c> lstLines = mapGLAccDetails.get(TL.OrderApi__Date__c);
                    lstLines.add(TL);
                    
                    // updateing map
                    mapGLAccDetails.put(TL.OrderApi__Date__c,lstLines);
                    
                    // updating main map
                    mapAccount_TransactionLine.put(TL.FON_Account_Number__c+'@'+TL.FON_Project_Number__c,mapGLAccDetails);
                }
                else{
                    List<OrderApi__Transaction_Line__c> lstLines = new List<OrderApi__Transaction_Line__c>();
                    lstLines.add(TL);
                    
                    // updateing map
                    mapGLAccDetails.put(TL.OrderApi__Date__c,lstLines);
                    
                    // updating main map
                    mapAccount_TransactionLine.put(TL.FON_Account_Number__c+'@'+TL.FON_Project_Number__c,mapGLAccDetails);
                }
            }
            else{
                map<date,List<OrderApi__Transaction_Line__c>> mapGLAccDetails = new map<date,List<OrderApi__Transaction_Line__c>>();
                List<OrderApi__Transaction_Line__c> lstLines = new List<OrderApi__Transaction_Line__c>();
                lstLines.add(TL);
                
                // updateing map
                mapGLAccDetails.put(TL.OrderApi__Date__c,lstLines);
                
                // updating main map
                mapAccount_TransactionLine.put(TL.FON_Account_Number__c+'@'+TL.FON_Project_Number__c,mapGLAccDetails);
            }
            
        }
        system.debug('\n--mapAccount_TransactionLine--'+mapAccount_TransactionLine);
        
        // we will be returning list of wrapper for report excel
        lstReportdata = new List<ReportWrapper>();
        
        // making list of wrapper which will be displayed in the report
        for(string GLAccountName : mapAccount_TransactionLine.keySet()){
            
            // getting Transaction Line Details
            map<date,List<OrderApi__Transaction_Line__c>> mapGLAccDetails = mapAccount_TransactionLine.get(GLAccountName);
            for(date Mapdate : mapGLAccDetails.keySet()){
                
                // this will save total for each date
                Decimal total = 0;
                
                ReportWrapper repData = new ReportWrapper();
                repData.GLAccount = GLAccountName;
                
                // getting record for the date 
                List<OrderApi__Transaction_Line__c> lstTransactionLines = mapGLAccDetails.get(Mapdate);
                for(OrderApi__Transaction_Line__c TL :lstTransactionLines){
                    if(TL.FON_Difference_Amount__c != null)
                        total += TL.FON_Difference_Amount__c;
                    
                    //repData.transCreateDate = TL.OrderApi__Transaction__r.CreatedDate.format();
                    repData.transCreateDate = DateTime.newInstance(TL.OrderApi__Transaction__r.CreatedDate.year(),TL.OrderApi__Transaction__r.CreatedDate.month(),TL.OrderApi__Transaction__r.CreatedDate.day()).format('yyyyMMdd');
                    repData.Fon_ProjectNumber = TL.FON_Project_Number__c;
                    repData.Fon_AccountNumber = TL.FON_Account_Number__c;
                    repData.Type = TL.OrderApi__Transaction__r.OrderApi__Type__c;
                    
                    TL.FON_Posted_In_Navision__c = TRUE;
                    updateLst.add(TL);    
                    
                }
                repData.order_Date = Mapdate.format();
                repData.total = total;
                system.debug('\n--repData--'+repData);
                lstReportdata.add(repData);
            }
        }
        system.debug('\n-lstReportdata---'+lstReportdata);
       update updateLst;   //Commented for for testing
        
    }
    
    
    public class ReportWrapper{
        public string GLAccount {get;set;}
        public string order_Date {get;set;}
        public decimal total {get;set;}
        public string transCreateDate {get;set;}
        public string Fon_ProjectNumber {get;set;}
        public string Fon_AccountNumber {get;set;}
        public string Type {get;set;}
    }
    
    
    
}