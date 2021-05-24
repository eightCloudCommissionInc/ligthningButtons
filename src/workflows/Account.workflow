<?xml version="1.0" encoding="utf-8"?><Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Annual_Site_Profile_Reminder_Email</fullName>
        <description>Annual Site Profile Reminder Email</description>
        <protected>false</protected>
        <recipients>
            <field>npe01__One2OneContact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>healthysteps@zerotothree.org</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>HealthySteps_Emails/Annual_Site_Profile_Reminder</template>
    </alerts>
    <alerts>
        <fullName>Implementation_Plan_Reminder_Email</fullName>
        <description>Implementation Plan Reminder Email</description>
        <protected>false</protected>
        <recipients>
            <field>npe01__One2OneContact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>healthysteps@zerotothree.org</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>HealthySteps_Emails/Implementation_Plan_Reminder</template>
    </alerts>
    <alerts>
        <fullName>Initial_Site_Profile_Reminder_Email</fullName>
        <description>Initial Site Profile Reminder Email</description>
        <protected>false</protected>
        <recipients>
            <field>npe01__One2OneContact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>healthysteps@zerotothree.org</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>HealthySteps_Emails/Initial_Site_Profile_Reminder_Email</template>
    </alerts>
    <alerts>
        <fullName>Reminder_Please_complete_your_Readiness_Assessment_Form</fullName>
        <description>Reminder: Please complete your Readiness Assessment Form.</description>
        <protected>false</protected>
        <recipients>
            <field>npe01__One2OneContact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>healthysteps@zerotothree.org</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>HealthySteps_Emails/Reminder_Please_Complete_Your_Readiness_Assessment</template>
    </alerts>
    <alerts>
        <fullName>Send_Annual_Site_Profile_Thank_You_Email</fullName>
        <description>Send Annual Site Profile Thank You Email</description>
        <protected>false</protected>
        <recipients>
            <field>npe01__One2OneContact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>HealthySteps_Emails/Annual_Site_Profile_Thank_You</template>
    </alerts>
    <alerts>
        <fullName>Send_Implementation_Plan_Thank_You</fullName>
        <description>Send Implementation Plan Thank You</description>
        <protected>false</protected>
        <recipients>
            <field>cfg_Plan_Lead__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>HealthySteps_Emails/Implementation_Plan_Thank_You</template>
    </alerts>
    <alerts>
        <fullName>Send_Interest_Thank_You_Email</fullName>
        <description>Send Interest Thank You Email</description>
        <protected>false</protected>
        <recipients>
            <field>npe01__One2OneContact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>HealthySteps_Emails/Interest_Thank_You</template>
    </alerts>
    <alerts>
        <fullName>Send_Readiness_Assessment_Thank_You</fullName>
        <description>Send Readiness Assessment Thank You</description>
        <protected>false</protected>
        <recipients>
            <field>npe01__One2OneContact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>HealthySteps_Emails/Readiness_Assessment_Thank_You</template>
    </alerts>
    <alerts>
        <fullName>Send_Site_Profile_Thank_You_Email</fullName>
        <description>Send Site Profile Thank You Email</description>
        <protected>false</protected>
        <recipients>
            <field>npe01__One2OneContact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>HealthySteps_Emails/Site_Profile_Thank_You</template>
    </alerts>
    <alerts>
        <fullName>Thank_you_for_completing_your_Implementation_Plan</fullName>
        <description>Thank you for completing your Implementation Plan</description>
        <protected>false</protected>
        <recipients>
            <field>npe01__One2OneContact__c</field>
            <type>contactLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>HealthySteps_Emails/Implementation_Plan_Thank_You</template>
    </alerts>
    <fieldUpdates>
        <fullName>Annual_Site_Profile_Submitted_Online</fullName>
        <description>Set Annual Site Profile Submitted Online to False</description>
        <field>c4g_Annual_Site_Profile_Submitted_Online__c</field>
        <literalValue>0</literalValue>
        <name>Annual Site Profile Submitted Online</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Clear_Implementation_Complete</fullName>
        <field>Implementation_Plan_Completed__c</field>
        <name>Clear Implementation Complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Clear_Site_Profile_Complete</fullName>
        <field>cfg_Site_Profile_Completed__c</field>
        <name>Clear Site Profile Complete</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Merge_to_False</fullName>
        <field>cfg_Merge_Implementation_Plan__c</field>
        <literalValue>0</literalValue>
        <name>Set Merge to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Merge_to_False2</fullName>
        <field>cfg_Merge_Interest_Form__c</field>
        <literalValue>0</literalValue>
        <name>Set Merge to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Merge_to_False3</fullName>
        <field>cfg_Merge_Practice_Assessment__c</field>
        <literalValue>0</literalValue>
        <name>Set Merge to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Merge_to_False4</fullName>
        <field>cfg_Merge_Site_Profile__c</field>
        <literalValue>0</literalValue>
        <name>Set Merge to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Merge_to_False5</fullName>
        <field>cfg_Merge_Initial_Site_Profile__c</field>
        <literalValue>0</literalValue>
        <name>Set Merge to False</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Turn_off_submission_flag</fullName>
        <description>Checks off the checkbox that triggers the workflow</description>
        <field>Site_Profile_Submitted_Online__c</field>
        <literalValue>0</literalValue>
        <name>Turn off submission flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Unset_Submitted_Implementation_Plan</fullName>
        <field>Implementation_Plan_Submitted__c</field>
        <literalValue>0</literalValue>
        <name>Unset Submitted Implementation Plan</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Site_Status_to_Active</fullName>
        <description>Updates the Site Status to Active.</description>
        <field>C4G_Status__c</field>
        <literalValue>Active</literalValue>
        <name>Update Site Status to Active</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Site_Status_to_Interested</fullName>
        <field>C4G_Status__c</field>
        <literalValue>Interested</literalValue>
        <name>Update Site Status to Interested</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Site_status_to_Onboarding</fullName>
        <description>Update Site Status to Onboarding</description>
        <field>C4G_Status__c</field>
        <literalValue>Onboarding</literalValue>
        <name>Update Site status to Onboarding</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kw__Set_KW_Caucus_Former_RType</fullName>
        <field>RecordTypeId</field>
        <lookupValue>kw__KW_Caucus_Former</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set KW Caucus Former RType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kw__Set_KW_Caucus_RType</fullName>
        <field>RecordTypeId</field>
        <lookupValue>kw__KW_Caucus</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set KW Caucus RType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kw__Set_KW_Committee_Former_RType</fullName>
        <field>RecordTypeId</field>
        <lookupValue>kw__KW_Committee_Former</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set KW Committee Former RType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kw__Set_KW_Committee_RType</fullName>
        <field>RecordTypeId</field>
        <lookupValue>kw__KW_Account_Committee</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set KW Committee RType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kw__Set_KW_Former_RType</fullName>
        <field>RecordTypeId</field>
        <lookupValue>kw__KW_Former</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set KW Former RType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kw__Set_KW_Member_Former_RType</fullName>
        <field>RecordTypeId</field>
        <lookupValue>kw__KW_Legislative_Member_Former</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set KW Member Former RType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kw__Set_KW_Member_RType</fullName>
        <field>RecordTypeId</field>
        <lookupValue>kw__KW_Account_Member</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set KW Member RType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kw__Set_KW_Office_Former_RType</fullName>
        <field>RecordTypeId</field>
        <lookupValue>kw__KW_Account_Officer_Former</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set KW Office Former RType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kw__Set_KW_Office_RType</fullName>
        <field>RecordTypeId</field>
        <lookupValue>kw__KW_Account_Officer</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set KW Office RType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__KW_CountyDistrict</fullName>
        <field>kwzd__KW_CountyDistrict__c</field>
        <name>ZDM:Account:County District</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__KW_CountyDistrictDesc</fullName>
        <field>kwzd__KW_CountyDistrictDesc__c</field>
        <name>ZDM:Account:County District Desc</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__KW_MunicipalDistrict</fullName>
        <field>kwzd__KW_MunicipalDistrict__c</field>
        <name>ZDM:Account:Municipal District</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__KW_MunicipalDistrictDesc</fullName>
        <field>kwzd__KW_MunicipalDistrictDesc__c</field>
        <name>ZDM:Account:Municipal District Desc</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__KW_StateHouseDesc</fullName>
        <field>kwzd__KW_StateHouseDesc__c</field>
        <name>ZDM:Account:State House Desc</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__KW_StateSenateDesc</fullName>
        <field>kwzd__KW_StateSenateDesc__c</field>
        <name>ZDM:Account:State Senate Desc</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__KW_USHouseDesc</fullName>
        <field>kwzd__KW_USHouseDesc__c</field>
        <name>ZDM:Account:US House Desc</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__KW_USSenateDesc</fullName>
        <field>kwzd__KW_USSenateDesc__c</field>
        <name>ZDM:Account:US Senate Desc</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__Reset_KnowWho_Address_Flag</fullName>
        <field>kwzd__KnowWho_Address_Update__c</field>
        <literalValue>0</literalValue>
        <name>Reset KnowWho Address Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__Reset_Last_Processed_Date</fullName>
        <field>kwzd__KWD_Last_Processed_DT__c</field>
        <name>Reset Last Processed Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__Update_City_with_USPS_Verified_Addres</fullName>
        <field>BillingCity</field>
        <formula>kwzd__USPS_City__c</formula>
        <name>Update City with USPS Verified Addres</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__Update_State_with_USPS_Verified_Addres</fullName>
        <field>BillingState</field>
        <formula>kwzd__USPS_State__c</formula>
        <name>Update State with USPS Verified Addres</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__Update_Street_with_USPS_Verified_Addres</fullName>
        <field>BillingStreet</field>
        <formula>IF(ISBLANK(kwzd__USPS_Street_2__c),
kwzd__USPS_Street__c,
kwzd__USPS_Street__c &amp; ", " &amp; kwzd__USPS_Street_2__c
)</formula>
        <name>Update Street with USPS Verified Addres</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__Update_Zipcode_with_USPS_Verified_Addres</fullName>
        <field>BillingPostalCode</field>
        <formula>kwzd__USPS_Zip__c</formula>
        <name>Update Zipcode with USPS Verified Addres</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Account_County_Code</fullName>
        <field>kwzd__KW_CountyCode__c</field>
        <name>ZDM:Account:County Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Account_County_Name</fullName>
        <field>kwzd__KW_CountyName__c</field>
        <name>ZDM:Account:County Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Account_Error_Code</fullName>
        <field>kwzd__KW_Error_Code__c</field>
        <name>ZDM:Account:Error Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Account_House</fullName>
        <field>kwzd__KW_USHouseDistrict__c</field>
        <name>ZDM:Account:House</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Account_Latitude</fullName>
        <field>kwzd__Latitude__c</field>
        <name>ZDM:Account:Latitude</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Account_Longitude</fullName>
        <field>kwzd__Longitude__c</field>
        <name>ZDM:Account:Longitude</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Account_Muni_Code</fullName>
        <field>kwzd__KW_MunicipalCode__c</field>
        <name>ZDM:Account:Municipal Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Account_Muni_Name</fullName>
        <field>kwzd__KW_MunicipalName__c</field>
        <name>ZDM:Account:Municipal Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Account_Muni_Type</fullName>
        <field>kwzd__KW_MunicipalType__c</field>
        <name>ZDM:Account:Municipal Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Account_PO_Box_Reset</fullName>
        <field>kwzd__PO_Box__c</field>
        <literalValue>0</literalValue>
        <name>ZDM:Account:PO Box Reset</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Account_Senate</fullName>
        <field>kwzd__KW_USSenateDistrict__c</field>
        <name>ZDM:Account:Senate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Account_State_House</fullName>
        <field>kwzd__KW_StateHouseDistrict__c</field>
        <name>ZDM:Account:State House</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Account_State_Senate</fullName>
        <field>kwzd__KW_StateSenateDistrict__c</field>
        <name>ZDM:Account:State Senate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Account_Zip_4_Reset</fullName>
        <field>kwzd__Zip_4__c</field>
        <name>ZDM:Account:Zip 4 Reset</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <outboundMessages>
        <fullName>Create_Implementation_Plan_PDF</fullName>
        <apiVersion>44.0</apiVersion>
        <endpointUrl>https://workflow.congamerge.com/OBMListener.ashx</endpointUrl>
        <fields>Id</fields>
        <fields>Implementation_Plan_Merge__c</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>cloud4good@zerotothree.org</integrationUser>
        <name>Create Implementation Plan PDF</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>Create_Interest_Form_PDF</fullName>
        <apiVersion>44.0</apiVersion>
        <endpointUrl>https://workflow.congamerge.com/OBMListener.ashx</endpointUrl>
        <fields>Id</fields>
        <fields>cfg_Interest_Form_Merge__c</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>cloud4good@zerotothree.org</integrationUser>
        <name>Create Interest Form PDF</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>Create_Practice_Assessment_PDF</fullName>
        <apiVersion>44.0</apiVersion>
        <endpointUrl>https://workflow.congamerge.com/OBMListener.ashx</endpointUrl>
        <fields>Id</fields>
        <fields>Practice_Assessment_Merge__c</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>cloud4good@zerotothree.org</integrationUser>
        <name>Create Practice Assessment PDF</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>Create_Site_Profile_PDF</fullName>
        <apiVersion>44.0</apiVersion>
        <endpointUrl>https://workflow.congamerge.com/OBMListener.ashx</endpointUrl>
        <fields>Id</fields>
        <fields>Site_Profile_Merge__c</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>cloud4good@zerotothree.org</integrationUser>
        <name>Create Site Profile PDF</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>Initial_Site_Profile_Merge</fullName>
        <apiVersion>44.0</apiVersion>
        <endpointUrl>https://workflow.congamerge.com/OBMListener.ashx</endpointUrl>
        <fields>Id</fields>
        <fields>Initial_Site_Profile_Merge__c</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>cloud4good@zerotothree.org</integrationUser>
        <name>Initial Site Profile Merge</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>Clear Implementation Form Complete</fullName>
        <actions>
            <name>Clear_Implementation_Complete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This is need to reset the reminder process when a new plan is sent.</description>
        <formula>cfg_Implementation_Plan_Sent__c &gt; Priorvalue(cfg_Implementation_Plan_Sent__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Clear Site Profile Complete</fullName>
        <actions>
            <name>Clear_Site_Profile_Complete</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This is need to reset the reminder process when a new plan is sent.</description>
        <formula>DateMostRecentSiteProfileSent__c  &gt; Priorvalue(DateMostRecentSiteProfileSent__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Generate Annual Site Profile</fullName>
        <actions>
            <name>Set_Merge_to_False4</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Create_Site_Profile_PDF</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.cfg_Merge_Site_Profile__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Generate Initial Site Profile</fullName>
        <actions>
            <name>Set_Merge_to_False5</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Initial_Site_Profile_Merge</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.cfg_Merge_Initial_Site_Profile__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Implementation Plan Thank you and tasks</fullName>
        <actions>
            <name>Thank_you_for_completing_your_Implementation_Plan</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Set_Merge_to_False</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Create_Implementation_Plan_PDF</name>
            <type>OutboundMessage</type>
        </actions>
        <actions>
            <name>Review_Implementation_Plan1</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Review_Implementation_Plan2</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.cfg_Merge_Implementation_Plan__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Executes actions needed when the Implementation plan is submitted.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send New Site Interest Tasks</fullName>
        <actions>
            <name>Set_Merge_to_False2</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Create_Interest_Form_PDF</name>
            <type>OutboundMessage</type>
        </actions>
        <actions>
            <name>Follow_Up_With_Interested_Site_Kidane</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.cfg_Merge_Interest_Form__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Create a Task to Follow Up with a HealthySteps Site that has expressed interest.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Thank You Annual Site Profile</fullName>
        <actions>
            <name>Send_Annual_Site_Profile_Thank_You_Email</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Annual_Site_Profile_Submitted_Online</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Review_Annual_Site_Profile_Ptucha</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.c4g_Annual_Site_Profile_Submitted_Online__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Send the Site Profile Thank You email.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Thank You Initial Site Profile</fullName>
        <actions>
            <name>Send_Site_Profile_Thank_You_Email</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Review_Site_Profile2</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Review_Site_Profile3</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Review_Site_Profile4</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Review_Site_Profile5</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Site_Profile_Submitted_Online__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Send the Site Profile Thank You email.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Thank You Readiness</fullName>
        <actions>
            <name>Send_Readiness_Assessment_Thank_You</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Set_Merge_to_False3</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Create_Practice_Assessment_PDF</name>
            <type>OutboundMessage</type>
        </actions>
        <actions>
            <name>Review_Practice_Assessment2</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Review_Practice_Assessment4</name>
            <type>Task</type>
        </actions>
        <actions>
            <name>Review_Practice_Assessment_Moore</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.cfg_Merge_Practice_Assessment__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Send the Readiness Assessment Thank You email.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Site Status to Active</fullName>
        <actions>
            <name>Update_Site_Status_to_Active</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.C4G_HealthySteps_Institute_Training_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Updates the HealthySteps Site Status to 'Active' when a date is added to the Training Completed field.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Site Status to Interested</fullName>
        <actions>
            <name>Update_Site_Status_to_Interested</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Completed_Online_Interest_Form__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Updates the HealthySteps Site Status to 'Interested' when a Site Interest Form creates a new Account through FormAssembly.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Update Site status to Onboarding</fullName>
        <actions>
            <name>Update_Site_status_to_Onboarding</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.C4G_Date_Affiliate_Agreement_Signed__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Updates the HealthySteps Site Status to Onboarding when the Contract Execution Date is added to the Account record.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kw__Set KW Caucus Former RType</fullName>
        <actions>
            <name>kw__Set_KW_Caucus_Former_RType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.kw__KW_Template__c</field>
            <operation>equals</operation>
            <value>AccountCaucusFormer</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kw__Set KW Caucus RType</fullName>
        <actions>
            <name>kw__Set_KW_Caucus_RType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.kw__KW_Template__c</field>
            <operation>equals</operation>
            <value>AccountCaucus</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kw__Set KW Committee Former RType</fullName>
        <actions>
            <name>kw__Set_KW_Committee_Former_RType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.kw__KW_Template__c</field>
            <operation>equals</operation>
            <value>AccountCommitteeFormer</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kw__Set KW Committee RType</fullName>
        <actions>
            <name>kw__Set_KW_Committee_RType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.kw__KW_Template__c</field>
            <operation>equals</operation>
            <value>AccountCommittee</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kw__Set KW Former RType</fullName>
        <actions>
            <name>kw__Set_KW_Former_RType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.kw__KW_Template__c</field>
            <operation>equals</operation>
            <value>AccountFormer</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kw__Set KW Member Former RType</fullName>
        <actions>
            <name>kw__Set_KW_Member_Former_RType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.kw__KW_Template__c</field>
            <operation>equals</operation>
            <value>AccountMemberFormer</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kw__Set KW Member RType</fullName>
        <actions>
            <name>kw__Set_KW_Member_RType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.kw__KW_Template__c</field>
            <operation>equals</operation>
            <value>AccountMember</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kw__Set KW Office Former RType</fullName>
        <actions>
            <name>kw__Set_KW_Office_Former_RType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.kw__KW_Template__c</field>
            <operation>equals</operation>
            <value>AccountOfficerFormer</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kw__Set KW Office RType</fullName>
        <actions>
            <name>kw__Set_KW_Office_RType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Account.kw__KW_Template__c</field>
            <operation>equals</operation>
            <value>AccountOfficer</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kwzd__Reset Processed Date</fullName>
        <actions>
            <name>kwzd__ZDM_Account_County_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Account_County_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Account_House</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Account_Muni_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Account_Muni_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Account_Muni_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Account_Senate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Account_State_House</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Account_State_Senate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Reset ZDM Address Fields when address changed</description>
        <formula>AND (   OR(  ISCHANGED( BillingStreet),   ISCHANGED( BillingCity),   ISCHANGED( BillingState),   ISCHANGED( BillingPostalCode)  ),  kwzd__KnowWho_Address_Update__c = FALSE  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>kwzd__Reset ZDM Account Descr Fields on Address Update</fullName>
        <actions>
            <name>kwzd__KW_CountyDistrict</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__KW_CountyDistrictDesc</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__KW_MunicipalDistrict</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__KW_MunicipalDistrictDesc</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__KW_StateHouseDesc</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__KW_StateSenateDesc</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__KW_USHouseDesc</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__KW_USSenateDesc</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Reset ZDM Description Fiedls when address changed</description>
        <formula>AND (   OR(  ISCHANGED( BillingStreet),   ISCHANGED( BillingCity),   ISCHANGED( BillingState),   ISCHANGED( BillingPostalCode)  ),  kwzd__KnowWho_Address_Update__c = FALSE  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>kwzd__Reset ZDM Account Fields on Address Update</fullName>
        <actions>
            <name>kwzd__Reset_Last_Processed_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Account_Error_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Account_Latitude</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Account_Longitude</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Account_PO_Box_Reset</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Account_Zip_4_Reset</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Reset ZDM Processed Date when address changed</description>
        <formula>AND (   OR(  ISCHANGED( BillingStreet),   ISCHANGED( BillingCity),   ISCHANGED( BillingState),   ISCHANGED( BillingPostalCode)  ),  kwzd__KnowWho_Address_Update__c = FALSE  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>kwzd__Update Address with USPS Verified Address</fullName>
        <actions>
            <name>kwzd__Reset_KnowWho_Address_Flag</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__Update_City_with_USPS_Verified_Addres</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__Update_State_with_USPS_Verified_Addres</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__Update_Street_with_USPS_Verified_Addres</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__Update_Zipcode_with_USPS_Verified_Addres</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.kwzd__USPS_Verified__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.kwzd__KnowWho_Address_Update__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Use USPS Verified Address from KnowWho ZDM Process to update standard address fields</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kwzd__Update KW Flag when Non USPS Verified Address</fullName>
        <actions>
            <name>kwzd__Reset_KnowWho_Address_Flag</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.kwzd__USPS_Verified__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.kwzd__KnowWho_Address_Update__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>When not a USPS Deliverable Address from KnowWho ZDM , just reset the field so new updates trigger reset</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Follow_Up_With_Interested_Site</fullName>
        <assignedTo>mflores@zerotothree.org</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Follow Up With Interested Site - Flores</subject>
    </tasks>
    <tasks>
        <fullName>Follow_Up_With_Interested_Site_Kidane</fullName>
        <assignedTo>fkidane@zerotothree.org</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Follow Up With Interested Site - Kidane</subject>
    </tasks>
    <tasks>
        <fullName>Review_Annual_Site_Profile_Ptucha</fullName>
        <assignedTo>lptucha@zerotothree.org</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>7</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Annual Site Profile - Ptucha</subject>
    </tasks>
    <tasks>
        <fullName>Review_Implementation_Plan1</fullName>
        <assignedTo>lkrug@zerotothree.org</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>7</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Implementation Plan - Krug</subject>
    </tasks>
    <tasks>
        <fullName>Review_Implementation_Plan2</fullName>
        <assignedTo>lmoore@zerotothree.org</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>7</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Implementation Plan - Moore</subject>
    </tasks>
    <tasks>
        <fullName>Review_Practice_Assessment</fullName>
        <assignedTo>mflores@zerotothree.org</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Practice Assessment - Flores</subject>
    </tasks>
    <tasks>
        <fullName>Review_Practice_Assessment2</fullName>
        <assignedTo>fkidane@zerotothree.org</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Practice Assessment - Kidane</subject>
    </tasks>
    <tasks>
        <fullName>Review_Practice_Assessment3</fullName>
        <assignedTo>prasanna@zerotothree.org</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>7</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Practice Assessment - Gillespie</subject>
    </tasks>
    <tasks>
        <fullName>Review_Practice_Assessment4</fullName>
        <assignedTo>lkrug@zerotothree.org</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Practice Assessment - Krug</subject>
    </tasks>
    <tasks>
        <fullName>Review_Practice_Assessment_Gillespie2</fullName>
        <assignedTo>prasanna@zerotothree.org</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>7</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Practice Assessment - Gillespie</subject>
    </tasks>
    <tasks>
        <fullName>Review_Practice_Assessment_Moore</fullName>
        <assignedTo>lmoore@zerotothree.org</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>2</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Practice Assessment - Moore</subject>
    </tasks>
    <tasks>
        <fullName>Review_Site_Profile</fullName>
        <assignedTo>mflores@zerotothree.org</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>7</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Site Profile - Flores</subject>
    </tasks>
    <tasks>
        <fullName>Review_Site_Profile2</fullName>
        <assignedTo>fkidane@zerotothree.org</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>7</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Site Profile - Kidane</subject>
    </tasks>
    <tasks>
        <fullName>Review_Site_Profile3</fullName>
        <assignedTo>lmoore@zerotothree.org</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>7</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Site Profile - Moore</subject>
    </tasks>
    <tasks>
        <fullName>Review_Site_Profile4</fullName>
        <assignedTo>lkrug@zerotothree.org</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>7</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Site Profile - Krug</subject>
    </tasks>
    <tasks>
        <fullName>Review_Site_Profile5</fullName>
        <assignedTo>tmontes@zerotothree.org</assignedTo>
        <assignedToType>user</assignedToType>
        <dueDateOffset>7</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Not Started</status>
        <subject>Review Site Profile - Montes</subject>
    </tasks>
</Workflow>
