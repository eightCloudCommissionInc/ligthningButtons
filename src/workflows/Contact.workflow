<?xml version="1.0" encoding="utf-8"?><Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>GW_Volunteers__Volunteer_Signup_Notification_Email_Alert_Contact</fullName>
        <description>Volunteer Signup Notification Email Alert - Contact</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GW_Volunteers__Volunteers_Email_Templates/GW_Volunteers__Volunteer_Signup_Notification</template>
    </alerts>
    <alerts>
        <fullName>GW_Volunteers__Volunteer_Signup_Thank_You_Email_Alert_Contact</fullName>
        <description>Volunteer Signup Thank You Email Alert - Contact</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>GW_Volunteers__Volunteers_Email_Templates/GW_Volunteers__Volunteer_Signup_Thank_You</template>
    </alerts>
    <alerts>
        <fullName>Reminder_Please_complete_your_Readiness_Assessment_Form</fullName>
        <description>Reminder: Please complete your Readiness Assessment Form.</description>
        <protected>false</protected>
        <recipients>
            <field>Email</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>HealthySteps_Emails/Reminder_Please_Complete_Your_Readiness_Assessment</template>
    </alerts>
    <fieldUpdates>
        <fullName>Check_Training_Completed</fullName>
        <description>Checks the Training Completed checkbox to indicate a Contact has been trained at a HealthySteps Training session.</description>
        <field>C4G_Training_Completed__c</field>
        <literalValue>1</literalValue>
        <name>Check Training Completed</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Populate_Personal_Email_Field</fullName>
        <field>OrderApi__Personal_Email__c</field>
        <formula>Email</formula>
        <name>Populate Personal Email Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_is_HealthySteps</fullName>
        <field>Is_HealthySteps__c</field>
        <literalValue>1</literalValue>
        <name>Set is HealthySteps</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Contact_Mod_Date</fullName>
        <field>HL_Mod_Date__c</field>
        <formula>NOW()</formula>
        <name>Update Contact Mod Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kw__Set_KW_Member_Former_RType</fullName>
        <field>RecordTypeId</field>
        <lookupValue>kw__KW_Member_Former</lookupValue>
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
        <lookupValue>kw__KW_Member_Record</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set KW Member RType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kw__Set_KW_Office_RType</fullName>
        <field>RecordTypeId</field>
        <lookupValue>kw__KW_Officer_Record</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set KW Office RType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kw__Set_KW_Officer_Former_RType</fullName>
        <field>RecordTypeId</field>
        <lookupValue>kw__KW_Officer_Former</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set KW Officer Former RType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kw__Set_KW_Staffer_Former_RType</fullName>
        <field>RecordTypeId</field>
        <lookupValue>kw__KW_Staffer_Former</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set KW Staffer Former RType</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kw__Set_KW_Staffer_RType</fullName>
        <field>RecordTypeId</field>
        <lookupValue>kw__KW_Staffer_Record</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Set KW Staffer RType</name>
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
        <fullName>kwzd__Reset_Processed_Date_Contact</fullName>
        <field>kwzd__KWD_Last_Processed_DT__c</field>
        <name>Reset Processed Date (Contact)</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__Update_City_with_USPS_Verified_Addres</fullName>
        <field>MailingCity</field>
        <formula>kwzd__USPS_City__c</formula>
        <name>Update City with USPS Verified Addres</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__Update_State_with_USPS_Verified_Addres</fullName>
        <field>MailingState</field>
        <formula>kwzd__USPS_State__c</formula>
        <name>Update State with USPS Verified Addres</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__Update_Street_with_USPS_Verified_Addres</fullName>
        <field>MailingStreet</field>
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
        <field>MailingPostalCode</field>
        <formula>kwzd__USPS_Zip__c</formula>
        <name>Update Zipcode with USPS Verified Addres</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
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
        <fullName>kwzd__ZDM_Contact_County_Code</fullName>
        <field>kwzd__KW_CountyCode__c</field>
        <name>ZDM:Contact:County Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Contact_County_Name</fullName>
        <field>kwzd__KW_CountyName__c</field>
        <name>ZDM:Contact:County Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Contact_Error_Code</fullName>
        <field>kwzd__KW_Error_Code__c</field>
        <name>ZDM:Contact:Error Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Contact_House</fullName>
        <field>kwzd__KW_USHouseDistrict__c</field>
        <name>ZDM:Contact:House</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Contact_Latitude</fullName>
        <field>kwzd__Latitude__c</field>
        <name>ZDM:Contact:Latitude</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Contact_Longitude</fullName>
        <field>kwzd__Longitude__c</field>
        <name>ZDM:Contact:Longitude</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Contact_Muni_Code</fullName>
        <field>kwzd__KW_MunicipalCode__c</field>
        <name>ZDM:Contact:Municipal Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Contact_Muni_Name</fullName>
        <field>kwzd__KW_MunicipalName__c</field>
        <name>ZDM:Contact:Municipal Name</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Contact_Muni_Type</fullName>
        <field>kwzd__KW_MunicipalType__c</field>
        <name>ZDM:Contact:Municipal Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Contact_PO_Box_Reset</fullName>
        <field>kwzd__PO_Box__c</field>
        <literalValue>0</literalValue>
        <name>ZDM:Contact:PO Box Reset</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Contact_Senate</fullName>
        <field>kwzd__KW_USSenateDistrict__c</field>
        <name>ZDM:Contact:Senate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Contact_State_House</fullName>
        <field>kwzd__KW_StateHouseDistrict__c</field>
        <name>ZDM:Contact:State House</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Contact_State_Senate</fullName>
        <field>kwzd__KW_StateSenateDistrict__c</field>
        <name>ZDM:Contact:State Senate</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwzd__ZDM_Contact_Zip_4_Reset</fullName>
        <field>kwzd__Zip_4__c</field>
        <name>ZDM:Contact:Zip 4 Reset</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Null</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__ContactAlternateEmailUpdate</fullName>
        <field>npe01__AlternateEmail__c</field>
        <formula>Email</formula>
        <name>Contact.AlternateEmail.Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__ContactHomePhoneUpdate</fullName>
        <field>HomePhone</field>
        <formula>Phone</formula>
        <name>Contact.HomePhone.Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__ContactMobilePhoneUpdate</fullName>
        <field>MobilePhone</field>
        <formula>Phone</formula>
        <name>Contact.MobilePhone.Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__ContactOtherEmailUpdate</fullName>
        <field>OtherPhone</field>
        <formula>Phone</formula>
        <name>Contact.OtherEmail.Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__ContactPersonalEmailUpdate</fullName>
        <field>npe01__HomeEmail__c</field>
        <formula>Email</formula>
        <name>Contact.PersonalEmail.Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__ContactPreferredEmail</fullName>
        <field>Email</field>
        <formula>CASE( 
npe01__Preferred_Email__c , 

"Work", 
if(len(npe01__WorkEmail__c)&gt;0, npe01__WorkEmail__c, 
if(len(npe01__HomeEmail__c)&gt;0, npe01__HomeEmail__c, 
npe01__AlternateEmail__c)), 

"Personal", 
if(len(npe01__HomeEmail__c)&gt;0, npe01__HomeEmail__c, 
if(len(npe01__WorkEmail__c)&gt;0, npe01__WorkEmail__c, 
npe01__AlternateEmail__c)), 

"Home", 
if(len(npe01__HomeEmail__c)&gt;0, npe01__HomeEmail__c, 
if(len(npe01__WorkEmail__c)&gt;0, npe01__WorkEmail__c, 
npe01__AlternateEmail__c)), 

"Alternate", 
if(len(npe01__AlternateEmail__c)&gt;0, npe01__AlternateEmail__c, 
if(len(npe01__WorkEmail__c)&gt;0, npe01__WorkEmail__c, 
npe01__HomeEmail__c)), 

If(LEN(npe01__WorkEmail__c)&gt;0 , npe01__WorkEmail__c , 
if(LEN( npe01__HomeEmail__c)&gt;0, npe01__HomeEmail__c, 
npe01__AlternateEmail__c 
)))</formula>
        <name>Contact.PreferredEmail</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__ContactPreferredPhone</fullName>
        <description>Populates the standard Phone field displayed on activities based on the Preferred Phone field value.</description>
        <field>Phone</field>
        <formula>CASE(
  npe01__PreferredPhone__c ,
"Work",
  npe01__WorkPhone__c  ,
"Home",
 HomePhone,
"Mobile",
 MobilePhone,
"Other",
 OtherPhone,
If(LEN( npe01__WorkPhone__c )&gt;0 , npe01__WorkPhone__c  ,
if(LEN(  HomePhone)&gt;0,  HomePhone,
if(LEN( MobilePhone)&gt;0, MobilePhone,
OtherPhone
))))</formula>
        <name>Contact.PreferredPhone</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__ContactWorkEmailUpdate</fullName>
        <field>npe01__WorkEmail__c</field>
        <formula>Email</formula>
        <name>Contact.WorkEmail.Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__ContactWorkPhoneUpdate</fullName>
        <field>npe01__WorkPhone__c</field>
        <formula>Phone</formula>
        <name>Contact.WorkPhone.Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__PreferredPhonetoWork</fullName>
        <field>npe01__PreferredPhone__c</field>
        <literalValue>Work</literalValue>
        <name>Preferred Phone to Work</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__SetPrefEmailtoWork</fullName>
        <field>npe01__Preferred_Email__c</field>
        <literalValue>Work</literalValue>
        <name>Set Pref Email to Work</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__SetWorkEmailtoEmail</fullName>
        <field>npe01__WorkEmail__c</field>
        <formula>Email</formula>
        <name>Set Work Email to Email</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npe01__WorkPhonetoPhone</fullName>
        <field>npe01__WorkPhone__c</field>
        <formula>Phone</formula>
        <name>Work Phone to Phone</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>npo02__ContactPreferredPhone_WithHousehold</fullName>
        <description>FOR USE WITH HOUSEHOLDS. Populates the standard Phone field displayed on activities based on the Preferred Phone field value.</description>
        <field>Phone</field>
        <formula>CASE( 
npe01__PreferredPhone__c , 
"Work", 
npe01__WorkPhone__c , 
"Household",
 npo02__Formula_HouseholdPhone__c ,
"Home", 
HomePhone, 
"Personal",
HomePhone,
"Mobile", 
MobilePhone, 
"Other", 
OtherPhone, 
If(LEN( npe01__WorkPhone__c )&gt;0 , npe01__WorkPhone__c , 
if(LEN( HomePhone)&gt;0, HomePhone, 
if(LEN( MobilePhone)&gt;0, MobilePhone, 
OtherPhone 
))))</formula>
        <name>Contact.PreferredPhone_WithHousehold</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <outboundMessages>
        <fullName>Send_AdHoc_Survey</fullName>
        <apiVersion>43.0</apiVersion>
        <endpointUrl>https://zerotothree.az1.qualtrics.com/WRQualtricsServer/sfApi.php?r=outboundMessage&amp;u=UR_9XmZumODfZkWgFT&amp;s=SV_3g5XuPAmtExVYlD&amp;t=TR_6tDK8KTCh5MFEYR</endpointUrl>
        <fields>AccountId</fields>
        <fields>Email</fields>
        <fields>FirstName</fields>
        <fields>Id</fields>
        <fields>LastName</fields>
        <fields>npe01__WorkEmail__c</fields>
        <fields>npsp__Primary_Affiliation__c</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>cloud4good@zerotothree.org</integrationUser>
        <name>Send AdHoc Survey</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>Send_Annual_Site_Survey</fullName>
        <apiVersion>43.0</apiVersion>
        <endpointUrl>https://zerotothree.az1.qualtrics.com/WRQualtricsServer/sfApi.php?r=outboundMessage&amp;u=UR_9XmZumODfZkWgFT&amp;s=SV_esLIayki5TJbWJf&amp;t=TR_73et5QrpCACGR5r</endpointUrl>
        <fields>AccountId</fields>
        <fields>Email</fields>
        <fields>FirstName</fields>
        <fields>Id</fields>
        <fields>LastName</fields>
        <fields>npe01__WorkEmail__c</fields>
        <fields>npsp__Primary_Affiliation__c</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>cloud4good@zerotothree.org</integrationUser>
        <name>Send Annual Site Survey</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>Send_Quarterly_Site_Survey</fullName>
        <apiVersion>43.0</apiVersion>
        <endpointUrl>https://zerotothree.az1.qualtrics.com/WRQualtricsServer/sfApi.php?r=outboundMessage&amp;u=UR_9XmZumODfZkWgFT&amp;s=SV_di3Ax6zWp1X1rqR&amp;t=TR_cBdw0K4lc4FJgdD</endpointUrl>
        <fields>AccountId</fields>
        <fields>Email</fields>
        <fields>FirstName</fields>
        <fields>Id</fields>
        <fields>LastName</fields>
        <fields>npe01__WorkEmail__c</fields>
        <fields>npsp__Primary_Affiliation__c</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>cloud4good@zerotothree.org</integrationUser>
        <name>Send Quarterly Site Survey</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>Send_Test_Survey</fullName>
        <apiVersion>43.0</apiVersion>
        <description>For use with Qualtrics testing only. 
Test: Use Bilingual checkbox to trigger survey to test Account ID.</description>
        <endpointUrl>https://sjc1.qualtrics.com/triggers/api/v1/event?eventType=SalesforceOutboundMessage&amp;s=SV_eg21HMKKvxqWiB7&amp;u=UR_9XmZumODfZkWgFT&amp;t=OC_2zU9iGD3ZhBuotr&amp;b=zerotothree</endpointUrl>
        <fields>AccountId</fields>
        <fields>Email</fields>
        <fields>FirstName</fields>
        <fields>Id</fields>
        <fields>LastName</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>cloud4good@zerotothree.org</integrationUser>
        <name>Send Test Survey</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>Send_Training_Survey</fullName>
        <apiVersion>43.0</apiVersion>
        <endpointUrl>https://zerotothree.az1.qualtrics.com/WRQualtricsServer/sfApi.php?r=outboundMessage&amp;u=UR_9XmZumODfZkWgFT&amp;s=SV_b8gYONM2rMTvjhz&amp;t=TR_eDlIumCBRQtFxv7</endpointUrl>
        <fields>AccountId</fields>
        <fields>C4G_Training_Attended__c</fields>
        <fields>Email</fields>
        <fields>FirstName</fields>
        <fields>Id</fields>
        <fields>LastName</fields>
        <fields>npe01__WorkEmail__c</fields>
        <fields>npsp__Primary_Affiliation__c</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>cloud4good@zerotothree.org</integrationUser>
        <name>Send Training Survey</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>test_Send_Training_Survey</fullName>
        <apiVersion>45.0</apiVersion>
        <endpointUrl>https://zerotothree.az1.qualtrics.com/WRQualtricsServer/sfApi.php?r=outboundMessage&amp;u=UR_9XmZumODfZkWgFT&amp;s=SV_8H1ZcPcp8SmPhop&amp;t=TR_6yAG8pnIYvJBwih</endpointUrl>
        <fields>AccountId</fields>
        <fields>C4G_Training_Attended__c</fields>
        <fields>Email</fields>
        <fields>FirstName</fields>
        <fields>Id</fields>
        <fields>LastName</fields>
        <fields>npe01__WorkEmail__c</fields>
        <fields>npsp__Primary_Affiliation__c</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>cloud4good@zerotothree.org</integrationUser>
        <name>test Send Training Survey</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>FON-CONTACT-New Contact Email Alert</fullName>
        <actions>
            <name>New_Contact_has_been_created</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Workflow fires an email alert whenever a new Contact is created by the site guest user.</description>
        <formula>ISPICKVAL($Profile.UserType,'Guest')</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>GW_Volunteers__Volunteer Signup - Contact</fullName>
        <actions>
            <name>GW_Volunteers__Volunteer_Signup_Notification_Email_Alert_Contact</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>GW_Volunteers__Volunteer_Signup_Thank_You_Email_Alert_Contact</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>GW_Volunteers__Volunteer_Signup_Thank_You_Sent_Contact</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>When a contact is updated or created from VolunteersSignup(FS) or VolunteersJobListing(FS), thank them and notify the volunteer manager.  Note if you are not using VolunteersSignup(FS), you can de-activate this rule to avoid multiple emails being sent.</description>
        <formula>GW_Volunteers__Volunteer_Last_Web_Signup_Date__c =  TODAY()</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Populate Personal Email</fullName>
        <actions>
            <name>Populate_Personal_Email_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Email</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.OrderApi__Personal_Email__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send AdHoc Survey</fullName>
        <actions>
            <name>Send_AdHoc_Survey</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.C4G_Test_AdHoc_Survey__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Triggered when the Test AdHoc Survey checkbox is checked.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Annual Site Survey</fullName>
        <actions>
            <name>Send_Annual_Site_Survey</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.C4G_Test_Annual_Site_Survey__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Triggered when the Test Annual Site Survey checkbox is checked.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Quarterly Site Survey</fullName>
        <actions>
            <name>Send_Quarterly_Site_Survey</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.C4G_Test_Quarterly_Site_Survey__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Triggered when the Test Quarterly Site Survey checkbox is checked.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Send Training Survey</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Contact.C4G_Training_Completed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Triggered when the 'Training Completed' checkbox is checked. In Production, the Survey should be triggered 48 hours after Training Completed is checked.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Send_Training_Survey</name>
                <type>OutboundMessage</type>
            </actions>
            <timeLength>48</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Test Qualtrics Survey</fullName>
        <actions>
            <name>Send_Test_Survey</name>
            <type>OutboundMessage</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.C4G_Bilingual_Multilingual__c</field>
            <operation>equals</operation>
            <value>Yes</value>
        </criteriaItems>
        <description>For use with Qualtrics testing only.
Test: Use Bilingual checkbox to trigger survey to test Account ID.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Contact Mod Date</fullName>
        <actions>
            <name>Update_Contact_Mod_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the HL_Mod_Date__c field when an update occurs that should trigger an update of the record in Higher Logic</description>
        <formula>ISNEW() ||					
ISCHANGED(OrderApi__Preferred_Email__c) ||			
ISCHANGED(FirstName) ||			
ISCHANGED(LastName) ||									
ISCHANGED(Salutation) ||			
ISCHANGED(DonorApi__Suffix__c) ||			
ISCHANGED(Title) ||									
ISCHANGED(MailingStreet) ||		
ISCHANGED(MailingCity) ||			
ISCHANGED(MailingState) ||			
ISCHANGED(MailingPostalCode) ||		
ISCHANGED(MailingCountry) ||		
ISCHANGED(OrderApi__Preferred_Phone__c) ||				
ISCHANGED(OrderApi__Work_Phone__c) ||	
ISCHANGED(MobilePhone)	||
ISCHANGED(HomePhone) ||			
ISCHANGED(Fax) ||				
ISCHANGED(Is_HealthySteps__c)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>kw__Set KW Member Former RType</fullName>
        <actions>
            <name>kw__Set_KW_Member_Former_RType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.kw__KW_Template__c</field>
            <operation>equals</operation>
            <value>ContactMemberFormer</value>
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
            <field>Contact.kw__KW_Template__c</field>
            <operation>equals</operation>
            <value>ContactMember</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kw__Set KW Officer Former RType</fullName>
        <actions>
            <name>kw__Set_KW_Officer_Former_RType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.kw__KW_Template__c</field>
            <operation>equals</operation>
            <value>ContactOfficerFormer</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kw__Set KW Officer RType</fullName>
        <actions>
            <name>kw__Set_KW_Office_RType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.kw__KW_Template__c</field>
            <operation>equals</operation>
            <value>ContactOfficer</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kw__Set KW Staffer Former RType</fullName>
        <actions>
            <name>kw__Set_KW_Staffer_Former_RType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.kw__KW_Template__c</field>
            <operation>equals</operation>
            <value>ContactStaffFormer</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kw__Set KW Staffer RType</fullName>
        <actions>
            <name>kw__Set_KW_Staffer_RType</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.kw__KW_Template__c</field>
            <operation>equals</operation>
            <value>ContactStaff</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kwzd__Reset Processed Date %28Contact%29</fullName>
        <actions>
            <name>kwzd__Reset_Last_Processed_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__Reset_Processed_Date_Contact</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Contact_Error_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Contact_Latitude</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Contact_Longitude</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Contact_PO_Box_Reset</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Contact_Zip_4_Reset</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Reset ZDM System Fields when address changed</description>
        <formula>AND (   OR( ISCHANGED( MailingStreet),  ISCHANGED( MailingCity),  ISCHANGED( MailingState),  ISCHANGED( MailingPostalCode)  ),   kwzd__KnowWho_Address_Update__c = FALSE  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>kwzd__Reset ZDM Contact Descr Fields on Address Update</fullName>
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
        <description>Reset ZDM Description Fields when address changed</description>
        <formula>AND (  OR(  ISCHANGED( MailingStreet),   ISCHANGED( MailingCity),    ISCHANGED( MailingState),    ISCHANGED( MailingPostalCode)    ),   kwzd__KnowWho_Address_Update__c = FALSE )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>kwzd__Reset ZDM Contact Fields on Address Update</fullName>
        <actions>
            <name>kwzd__ZDM_Contact_County_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Contact_County_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Contact_House</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Contact_Muni_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Contact_Muni_Name</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Contact_Muni_Type</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Contact_Senate</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Contact_State_House</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwzd__ZDM_Contact_State_Senate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Reset ZDM Fields when address changed</description>
        <formula>AND (   OR( ISCHANGED( MailingStreet),  ISCHANGED( MailingCity),  ISCHANGED( MailingState),  ISCHANGED( MailingPostalCode)  ),   kwzd__KnowWho_Address_Update__c = FALSE  )</formula>
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
        <active>false</active>
        <criteriaItems>
            <field>Contact.kwzd__USPS_Verified__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.kwzd__KnowWho_Address_Update__c</field>
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
            <field>Contact.kwzd__USPS_Verified__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.kwzd__KnowWho_Address_Update__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>When not a USPS Deliverable Address from KnowWho ZDM , just reset the field so new updates trigger reset</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Contact%2EEmailChanged_Alternate</fullName>
        <actions>
            <name>npe01__ContactAlternateEmailUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If the standard Email field is newly entered or changed AND the Preferred Email picklist is set to Alternate THEN Salesforce will fill in the Alternate Email field with the email address entered in the standard Email field.</description>
        <formula>AND(      ISPICKVAL( npe01__Preferred_Email__c ,"Alternate"),      OR(           AND(                ISNEW(),                LEN(Email)&gt;0           ),           ISCHANGED( Email )      ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Contact%2EEmailChanged_Personal</fullName>
        <actions>
            <name>npe01__ContactPersonalEmailUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If the standard Email field is newly entered or changed AND the Preferred Email picklist is set to Personal or Home THEN Salesforce will fill in the Personal Email field with the email address entered in the standard Email field.</description>
        <formula>AND(     OR( ISPICKVAL( npe01__Preferred_Email__c ,"Personal"),ISPICKVAL( npe01__Preferred_Email__c ,"Home")),      OR(           AND(                ISNEW(),                LEN(Email)&gt;0           ),           ISCHANGED( Email )      ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Contact%2EEmailChanged_Work</fullName>
        <actions>
            <name>npe01__ContactWorkEmailUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If the standard Email field is newly entered or changed AND the Preferred Email picklist is set to Work THEN Salesforce will fill in the Work Email field with the email address entered in the standard Email field.</description>
        <formula>AND(      ISPICKVAL( npe01__Preferred_Email__c ,"Work"),      OR(           AND(                ISNEW(),                LEN(Email)&gt;0           ),           ISCHANGED( Email )      ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Contact%2EPhoneChanged_Home</fullName>
        <actions>
            <name>npe01__ContactHomePhoneUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If the standard Phone field is newly entered or changed AND the Preferred Phone picklist is set to Home THEN Salesforce will fill in the Home Phone field with the phone number entered in the standard Phone field.</description>
        <formula>AND(      ISPICKVAL( npe01__PreferredPhone__c ,"Home"),      OR(           AND(                ISNEW(),                LEN(Phone)&gt;0           ),           ISCHANGED( Phone )      ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Contact%2EPhoneChanged_Mobile</fullName>
        <actions>
            <name>npe01__ContactMobilePhoneUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If the standard Phone field is newly entered or changed AND the Preferred Phone picklist is set to Mobile THEN Salesforce will fill in the Mobile Phone field with the phone number entered in the standard Phone field.</description>
        <formula>AND(      ISPICKVAL( npe01__PreferredPhone__c ,"Mobile"),      OR(           AND(                ISNEW(),                LEN(Phone)&gt;0           ),           ISCHANGED( Phone )      ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Contact%2EPhoneChanged_Other</fullName>
        <actions>
            <name>npe01__ContactOtherEmailUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If the standard Phone field is newly entered or changed AND the Preferred Phone picklist is set to Other THEN Salesforce will fill in the Other Phone field with the phone number entered in the standard Phone field.</description>
        <formula>AND(      ISPICKVAL( npe01__PreferredPhone__c ,"Other"),      OR(           AND(                ISNEW(),                LEN(Phone)&gt;0           ),           ISCHANGED( Phone )      ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Contact%2EPhoneChanged_Work</fullName>
        <actions>
            <name>npe01__ContactWorkPhoneUpdate</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If the standard Phone field is newly entered or changed AND the Preferred Phone picklist is set to Work THEN Salesforce will fill in the Work Phone field with the phone number entered in the standard Phone field.</description>
        <formula>AND(      ISPICKVAL( npe01__PreferredPhone__c ,"Work"),      OR(           AND(                ISNEW(),                LEN(Phone)&gt;0           ),           ISCHANGED( Phone )      ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Contact%2EPreferred_Email%5F%5Fc</fullName>
        <actions>
            <name>npe01__ContactPreferredEmail</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow OVERWRITES the existing value in the standard Email field based on the Preferred Email field value.  This rule needs to be turned on manually after an Upgrade to this package.</description>
        <formula>OR( LEN(Email)=0, ISCHANGED(npe01__Preferred_Email__c) , ISCHANGED(npe01__WorkEmail__c) , ISCHANGED(npe01__HomeEmail__c) , ISCHANGED(npe01__AlternateEmail__c)  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Contact%2EPreferred_Phone%5F%5Fc</fullName>
        <actions>
            <name>npe01__ContactPreferredPhone</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This workflow OVERWRITES the existing value in the standard Phone field based on the Preferred Phone field value.  This rule needs to be turned on manually after an Upgrade to this package.</description>
        <formula>OR(  LEN(Phone)=0, ISCHANGED(npe01__PreferredPhone__c) ,  ISCHANGED(npe01__WorkPhone__c) ,  ISCHANGED(HomePhone) ,  ISCHANGED(MobilePhone) , ISCHANGED(OtherPhone)  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Email only%3A Paste to Work</fullName>
        <actions>
            <name>npe01__SetPrefEmailtoWork</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>npe01__SetWorkEmailtoEmail</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Email</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.npe01__Preferred_Email__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.npe01__HomeEmail__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.npe01__AlternateEmail__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.npe01__WorkEmail__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>If there is a value in the standard Email field AND no values in any NPSP email fields or Preferred Email, then Salesforce updates two fields: Work Email is updated with the email address in the standard Email field and Preferred Email is set to Work.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>npe01__Phone only%3A Paste to Work</fullName>
        <actions>
            <name>npe01__PreferredPhonetoWork</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>npe01__WorkPhonetoPhone</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6</booleanFilter>
        <criteriaItems>
            <field>Contact.Phone</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.npe01__PreferredPhone__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.npe01__WorkPhone__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.MobilePhone</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.HomePhone</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Contact.OtherPhone</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>If there is a value in the standard Phone field AND no values in any NPSP phone fields or Preferred Phone, then Salesforce updates two fields: Work Phone is updated with the phone number in the standard Phone field and Preferred Phone is set to Work.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>npo02__Contact%2EPreferred_Phone%5F%5Fc WithHousehold</fullName>
        <active>true</active>
        <description>DEPRICATED: This workflow does not do anything yet.</description>
        <formula>1=2</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <tasks>
        <fullName>GW_Volunteers__Volunteer_Signup_Thank_You_Sent_Contact</fullName>
        <assignedToType>owner</assignedToType>
        <description>An automatic thank you email has been sent to the contact for signing up to be a volunteer.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Completed</status>
        <subject>Volunteer Signup Thank You Sent - Contact</subject>
    </tasks>
</Workflow>
