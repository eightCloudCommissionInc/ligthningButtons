/**
 * Created by daweima on 5/27/20.
 */
@IsTest
public without sharing class FS_CommunityGroupITCPFlagTest {

    @TestSetup
    private static void install() {

        Framework.Installer.install();
        PagesApi.PackageScripts.install();
        OrderApi.PackageScripts.install();
        EventApi.PackageScripts.install();
        ROEApi.PackageScripts.install();
        CPBase.PackageScripts.install();
        LTE.PackageScripts.install();
        FDService.BUPackageScripts.install();
        DonorApi.PackageScripts.install();
        joinapi.PackageScripts.install();
        PriceApi.PackageScripts.install();

        Framework.RoutingRule[] rules = new List<Framework.RoutingRule>();
        Framework.RoutingRule routingRule = new Framework.RoutingRule();
        routingRule.apexClass = FS_CommunityGroupITCPFlagsRule.class.getName();
        routingRule.namespace = '';
        routingRule.isEnabled = true;
        routingRule.sObjectName = 'Contact';
        routingRule.executionOrder = 10;
        rules.add(routingRule);
        Framework.Config.push(rules);

    }
    @IsTest
    public static void test(){
        Contact c = new Contact(LastName='testdavid', ITCP_Community_Member__c = true);
        insert c;

        c.ITCP_Community_Member__c = false;
        update c;
    }
}