<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include virtual ="/global_includes/emailUtils.inc"-->
<%
logNumber		= request("logNumber")
viewDivision	= request("viewDivision")
requestor		= request("requestor")


email_to			= "alex.vargas@delta.com"
email_cc			= "alex.vargas@delta.com,bunty.ramakrishna@delta.com"
email_bcc			= "mike.aaron@gmail.com"
email_body			= email_body
email_subject		= "Request to demote from iSRT - "& viewDivision & logNumber

email_body2 = "<br><br><b>Request to demote from iSRT for: </b><br>"& viewDivision & logNumber &"<br><br><b>Requested By: </b><br>"& session("first_name") &" "& session("last_name") &" ("& session("employee_number") &")"

'sendSRTEmail email_to, email_cc, email_bcc, email_from, email_subject, email_body2, attachments


%><response><result>Request Sent</result></response>