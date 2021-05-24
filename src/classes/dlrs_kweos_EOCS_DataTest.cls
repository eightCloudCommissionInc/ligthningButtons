/**
 * Auto Generated and Deployed by the Declarative Lookup Rollup Summaries Tool package (dlrs)
 **/
@IsTest
private class dlrs_kweos_EOCS_DataTest
{
    @IsTest
    private static void testTrigger()
    {
        // Force the dlrs_kweos_EOCS_DataTrigger to be invoked, fails the test if org config or other Apex code prevents this.
        dlrs.RollupService.testHandler(new kweos__EOCS_Data__c());
    }
}