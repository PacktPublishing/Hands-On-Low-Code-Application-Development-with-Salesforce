<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Send_big_deal_data_to_key_Sales_users</fullName>
        <ccEmails>lollo@myspaghetti.it</ccEmails>
        <description>Send big deal data to key Sales users</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <recipients>
            <recipient>CEO</recipient>
            <type>role</type>
        </recipients>
        <recipients>
            <recipient>no.code.book@enree.co</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Sales_New_Big_Deal</template>
    </alerts>
    <fieldUpdates>
        <fullName>Update_Opp_ty_Close_Date</fullName>
        <description>Updates the Close Date with Today</description>
        <field>CloseDate</field>
        <formula>TODAY()</formula>
        <name>Update Opp.ty Close Date</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Opp_ty_description</fullName>
        <field>Description</field>
        <formula>IF( 
  AND(
    IsClosed, 
    ISPICKVAL(StageName, &apos;Closed Won&apos;),
    OR( Amount &gt;= 1000000, ISPICKVAL(Account.Rating, &apos;Hot&apos;))
  ),
  &apos;ALERT: this is a *HOT DEAL* with&apos; + 
    IF(Amount &gt;= 1000000, 
      &apos;an Amount higher than $1M!&apos;,
      &apos;a *Hot* customer!&apos;
   ),
   Description
)</formula>
        <name>Update Opp.ty description</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <outboundMessages>
        <fullName>Call_Order_Management_System</fullName>
        <apiVersion>48.0</apiVersion>
        <endpointUrl>https://enff8b10d8h76.x.pipedream.net</endpointUrl>
        <fields>Amount</fields>
        <fields>CloseDate</fields>
        <fields>Description</fields>
        <fields>Id</fields>
        <fields>Name</fields>
        <fields>StageName</fields>
        <includeSessionId>false</includeSessionId>
        <integrationUser>no.code.book@enree.co</integrationUser>
        <name>Call Order Management System</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>Big_Deal_Closed</fullName>
        <actions>
            <name>Send_big_deal_data_to_key_Sales_users</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Update_Opp_ty_Close_Date</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Opp_ty_description</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Call_Order_Management_System</name>
            <type>OutboundMessage</type>
        </actions>
        <actions>
            <name>New_Big_Deal</name>
            <type>Task</type>
        </actions>
        <active>true</active>
        <description>A big is closed and proper actions can be executed</description>
        <formula>AND(
  IsClosed,
  ISPICKVAL(StageName, &apos;Closed Won&apos;),
  OR(
     Amount &gt;= 1000000,
     ISPICKVAL(Account.Rating, &apos;Hot&apos;)
  )
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>New_Big_Deal</fullName>
        <assignedTo>CEO</assignedTo>
        <assignedToType>role</assignedToType>
        <description>Hey boss, a new big deal has just been created!</description>
        <dueDateOffset>5</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Opportunity.CloseDate</offsetFromField>
        <priority>High</priority>
        <protected>false</protected>
        <status>In Progress</status>
        <subject>New Big Deal!</subject>
    </tasks>
</Workflow>
