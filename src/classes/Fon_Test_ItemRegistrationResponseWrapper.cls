@isTest
public class Fon_Test_ItemRegistrationResponseWrapper {
   
    static testMethod void method1(){ 
         //String json ='Test';
        String json = '{"product_url":"www.google.com","registration_id":1}';
        Fon_ItemRegistrationResponseWrapper responseWrapper = Fon_ItemRegistrationResponseWrapper.parse(json);
    }
}