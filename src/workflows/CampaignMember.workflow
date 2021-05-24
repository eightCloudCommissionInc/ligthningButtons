<?xml version="1.0" encoding="utf-8"?><Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Reminder_Complete_your_survey</fullName>
        <description>Reminder: Complete your survey</description>
        <protected>false</protected>
        <recipients>
            <field>ContactId</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>healthysteps@zerotothree.org</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>HealthySteps_Emails/Reminder_Please_Complete_Your_recent_survey_invite</template>
    </alerts>
</Workflow>
