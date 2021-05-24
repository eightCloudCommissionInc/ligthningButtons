@isTest
public with sharing class Fon_TestPackageScript {
	
  	static testMethod void testInstallScripts() {
  		Test.startTest();
    	Fon_PackageScript.testInstall();
      	
      	Test.stopTest();
  	}
}