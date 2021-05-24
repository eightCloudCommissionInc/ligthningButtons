<?xml version="1.0" encoding="utf-8"?><Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Reminder_Please_complete_your_Readiness_Assessment_Form</fullName>
        <description>Reminder: Please complete your Readiness Assessment Form.</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>HealthySteps_Emails/Reminder_Please_Complete_Your_Readiness_Assessment</template>
    </alerts>
    <rules>
        <fullName>Update Site Status to Exploration</fullName>
        <active>false</active>
        <criteriaItems>
            <field>Task.C4G_Call_Type__c</field>
            <operation>equals</operation>
            <value>Practice Assessment Call</value>
        </criteriaItems>
        <criteriaItems>
            <field>Task.Status</field>
            <operation>equals</operation>
            <value>Completed</value>
        </criteriaItems>
        <description>MOVED TO PROCESS BUILDER</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
