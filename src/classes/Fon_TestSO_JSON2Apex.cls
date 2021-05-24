@isTest
public class Fon_TestSO_JSON2Apex {
    static testMethod void method1(){ 
        //String json ='Test';
        String json = '{"productUrl":"www.google.com","transactionAffiliation":"testtrans","transactionTotal":20.20,"transactionTax":10.10,"transactionShipping":10}';
        SO_JSON2Apex responseWrapper = SO_JSON2Apex.parse(json);
    }
}