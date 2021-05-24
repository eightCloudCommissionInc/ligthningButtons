<?xml version="1.0" encoding="utf-8"?><Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>FON_Send_Staff_CEU_Survey_Responses</fullName>
        <ccEmails>CEU@zerotothree.org</ccEmails>
        <description>Send Staff CEU Survey Responses</description>
        <protected>false</protected>
        <senderAddress>communities@zerotothree.org</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Worflow_Emails/FON_CEU_Survey_Responses2</template>
    </alerts>
    <rules>
        <fullName>Send Staff CEU Survey Responses</fullName>
        <actions>
            <name>FON_Send_Staff_CEU_Survey_Responses</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>FON_CEU_Survey__c.FON_CEU_Attendee_Confirmation_Checkbox__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
