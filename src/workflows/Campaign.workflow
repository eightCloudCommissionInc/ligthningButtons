<?xml version="1.0" encoding="utf-8"?><Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Set_Action_Center_Base_URL</fullName>
        <field>kwac__Public_URL__c</field>
        <formula>"https://zerotothree.secure.force.com/actions/TakeActionOne"</formula>
        <name>Set Action Center Base URL</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Action_Request_Id</fullName>
        <field>kwac__Action_Request2_Id__c</field>
        <formula>Action_ID_Generator__c</formula>
        <name>Set Action Request Id</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Button_Color</fullName>
        <field>kwac__Button_Display_Color__c</field>
        <formula>"#008dcb"</formula>
        <name>Set Button Color</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Header_Color</fullName>
        <field>kwac__Header_Section_Color__c</field>
        <formula>"#143f64"</formula>
        <name>Set Header Color</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwac__Default_Create_Advocacy_Records_to_True</fullName>
        <field>kwac__Create_Related_Advocacy_Records__c</field>
        <literalValue>1</literalValue>
        <name>Default Create Advocacy Records to True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwac__Disable_Message_Edit</fullName>
        <description>Disable ability to edit Message on an Action</description>
        <field>kwac__User_Can_Edit_Message__c</field>
        <literalValue>0</literalValue>
        <name>Disable Message Edit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwac__Disable_Subject_Edit</fullName>
        <description>Disable ability to edit Subject on Action Messages</description>
        <field>kwac__User_Can_Edit_Subject__c</field>
        <literalValue>0</literalValue>
        <name>Disable Subject Edit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwac__Set_Include_in_Public_To_True</fullName>
        <description>When Sharing URL created, set Include in Public to TRUE</description>
        <field>kwac__Include_in_Public_Action_List__c</field>
        <literalValue>1</literalValue>
        <name>Set Include in Public To True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwac__Set_Invoke_ZDM_Flag_to_FALSE</fullName>
        <description>Turn off ZDM service for Petitions</description>
        <field>kwac__Invoke_ZDM_Service__c</field>
        <literalValue>0</literalValue>
        <name>Set Invoke ZDM Flag to FALSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwac__Set_Invoke_ZDM_Flag_to_TRUE</fullName>
        <field>kwac__Invoke_ZDM_Service__c</field>
        <literalValue>1</literalValue>
        <name>Set Invoke ZDM Flag to TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwac__Set_Issue_Code</fullName>
        <field>kwac__KnowWho_Issues_Code__c</field>
        <formula>Case (kwac__Action_Page_Issues_Code__c , 
"Abortion","56", 
"Acquisitions","57", 
"Aerospace / Space","40", 
"Agriculture / Food"," 2", 
"Animal Rights"," 3", 
"Appropriations"," 4", 
"Arts / Humanities"," 5", 
"Banking","58", 
"Budget","59", 
"Census / Redistricting"," 9", 
"Commerce / Business"," 7", 
"Communications","12", 
"Congress","60", 
"Consumer Affairs","13", 
"Crime / Law Enforcement","14", 
"Disabilities / ADA","16", 
"Disaster / Emergency Management / FEMA","17", 
"Economic Development / Economic Policy","55", 
"Education / Schools","18", 
"Elections / Campaigns"," 8", 
"Energy / Utilities","19", 
"Entertainment / Media","20", 
"Environment / Natural Resources","21", 
"Family / Children","10", 
"Finance"," 6", 
"Foreign Policy / International Affairs","22", 
"Gambling","61", 
"Government Operations / Government Reform","23", 
"Grants / Interns","41", 
"Gun Issues","62", 
"Health / Medicine","24", 
"Homeland Security / Terrorism","25", 
"Housing","26", 
"Human Rights / Civil Rights","11", 
"Immigration","27", 
"Insurance","49", 
"Intelligence / Counterintelligence","28", 
"Intergovernmental Affairs / State / Local","53", 
"Internet / Social Media","69", 
"Judiciary / Law / Courts","29", 
"Labor / Jobs / Pensions","30", 
"Land Use / Water / Oceans","46", 
"Lobbying / Politics","63", 
"Logistics / Planning","52", 
"Medicare / Medicaid","31", 
"Military / Defense","15", 
"Minority / Ethnic","33", 
"National Security","64", 
"Native American Affairs","65", 
"Privacy / Personal Rights","70", 
"Public Affairs / Outreach","54", 
"Public Works / Infrastructure","32", 
"Recreation / Sports / Parks","34", 
"Regulation / Regulatory","50", 
"Religion","35", 
"Rules / Ethics","36", 
"Rural Affairs","37", 
"Science","38", 
"Seniors / Aging / Elderly"," 1", 
"Small Business","66", 
"Social Security","39", 
"Tax / Revenue","42", 
"Technology","67", 
"Telecommunications","68", 
"Trade / Exports / Imports","43", 
"Transportation","44", 
"Urban Affairs / Urban Development","51", 
"Veterans Affairs","45", 
"Welfare / Social Issues","47", 
"Womens Issues","48", 
"")</formula>
        <name>Set Issue Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwac__Set_Sharing_URL</fullName>
        <description>URL with no Contact Id that can be shared on social media</description>
        <field>kwac__URL_to_Share__c</field>
        <formula>kwac__Public_URL__c &amp; "?actionId=" &amp;  kwac__Action_Request2_Id__c</formula>
        <name>Set Sharing URL</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwac__Set_Submit_to_Officials_to_FALSE</fullName>
        <description>Disable when Petition Selected</description>
        <field>kwac__Submit_Messages_to_Officials__c</field>
        <literalValue>0</literalValue>
        <name>Set Submit to Officials to FALSE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>kwac__Set_Submit_to_Officials_to_TRUE</fullName>
        <description>Added so we can base this action on Action Type Field</description>
        <field>kwac__Submit_Messages_to_Officials__c</field>
        <literalValue>1</literalValue>
        <name>Set Submit to Officials to TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>false</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Set Action Center Base URL</fullName>
        <actions>
            <name>Set_Action_Center_Base_URL</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Button_Color</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Set_Header_Color</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Campaign.RecordTypeId</field>
            <operation>equals</operation>
            <value>Actions</value>
        </criteriaItems>
        <description>Set base URL for all actions</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Set Action Request Id</fullName>
        <actions>
            <name>Set_Action_Request_Id</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Campaign.Action_ID_Generator__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Campaign.kwac__Action_Request2_Id__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kwac__Disable Edit for Petitions</fullName>
        <actions>
            <name>kwac__Disable_Message_Edit</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwac__Disable_Subject_Edit</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Campaign.kwac__Submit_Messages_to_Officials__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <description>When action messages are just to sign Petitions, disable ability to change messages by default</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kwac__Set Action Center Defaults</fullName>
        <actions>
            <name>kwac__Default_Create_Advocacy_Records_to_True</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Campaign.kwac__Action_Page_Issues_Code__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Set Default Checkbox Values</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>kwac__Set KW Issue Code</fullName>
        <actions>
            <name>kwac__Set_Issue_Code</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Campaign.kwac__Action_Page_Issues_Code__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kwac__Set Submit to Officials for Contact Officials</fullName>
        <actions>
            <name>kwac__Set_Submit_to_Officials_to_TRUE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Campaign.kwac__Action_Type__c</field>
            <operation>equals</operation>
            <value>Contact Officials</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kwac__Set Submit to Officials for Petitions</fullName>
        <actions>
            <name>kwac__Set_Submit_to_Officials_to_FALSE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Campaign.kwac__Action_Type__c</field>
            <operation>notEqual</operation>
            <value>Contact Officials</value>
        </criteriaItems>
        <description>Disable Contact Officials when Petitions are selected</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kwac__Set URL to Share</fullName>
        <actions>
            <name>kwac__Set_Include_in_Public_To_True</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>kwac__Set_Sharing_URL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Campaign.kwac__Public_URL__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Sets the Shareable URL for a Campaign. This is only set on create, so that it can be overridden by a shortened version etc</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>kwac__Set Use ZDM Flag</fullName>
        <actions>
            <name>kwac__Set_Invoke_ZDM_Flag_to_TRUE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Campaign.kwac__Action_Type__c</field>
            <operation>equals</operation>
            <value>Contact Officials,Petition with Address Matching</value>
        </criteriaItems>
        <description>For actions requiring elected officials to be displayed/contacted, we invoke ZDM which requires an address to added to an action</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>kwac__Set Use ZDM Flag to Off</fullName>
        <actions>
            <name>kwac__Set_Invoke_ZDM_Flag_to_FALSE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Campaign.kwac__Action_Type__c</field>
            <operation>equals</operation>
            <value>Petition</value>
        </criteriaItems>
        <description>For simple petitions, turn off ZDM so we can capture petitions without a full address</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
