<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Alert_Submitter_for_Rejection</fullName>
        <description>Alert Submitter for Rejection</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Adv_Discount_Rejected</template>
    </alerts>
    <alerts>
        <fullName>Alert_submitter_for_Approval</fullName>
        <description>Alert submitter for Approval</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Adv_Discount_Approved</template>
    </alerts>
    <fieldUpdates>
        <fullName>Discount_Approval_Rejected</fullName>
        <field>Discount_Approved__c</field>
        <literalValue>Not Approved</literalValue>
        <name>Discount Approval Rejected</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Discount_Approval_Requested</fullName>
        <field>Discount_Approved__c</field>
        <literalValue>Approval Requested</literalValue>
        <name>Discount Approval Requested</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Discount_Approved</fullName>
        <field>Discount_Approved__c</field>
        <literalValue>Approved</literalValue>
        <name>Discount Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Reset_Discount_Status</fullName>
        <field>Discount_Approved__c</field>
        <name>Reset Discount Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Reset Approval Status</fullName>
        <actions>
            <name>Reset_Discount_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(
				Discount__c &gt; 0,
				Price__c &gt; 0,
    ISCHANGED(Discount__c),
				PRIORVALUE(Discount__c) &lt; Discount__c
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
