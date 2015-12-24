<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include virtual ="/global_includes/emailUtils.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<%
logNumber		= request("logNumber")
viewDivision	= request("viewDivision")
requestor		= request("requestor")

log_numberSTR	= string(4-len(log_number),"0")&log_number

sql = "select email_address from Tbl_Logins where division = "& sqltext2(viewDivision) &" and srt_admin = 'p'"
set rs=conn_asap.execute(sql)
do while not rs.eof

  toStr = toStr & rs("email_address") &","
  rs.movenext
loop

'email_to			= toStr
email_to			= "mike.aaron@gmail.com"
email_cc			= ""
email_bcc			= "alex.vargas@delta.com,bunty.ramakrishna@delta.com,mike.aaron@gmail.com"
email_body			= email_body
email_subject		= "Request Addition to Divisional SRT - STG"& log_numberSTR

email_body2 = "<br><br><b>Request Addition to Divisional SRT for: </b><br>STG"& log_numberSTR &"<br><br><b>Requested By: </b><br>"& session("first_name") &" "& session("last_name") &" ("& session("employee_number") &")"

email_body2 = email_body2 &"<br><br>Real to :"& toStr

'sendSRTEmail email_to, email_cc, email_bcc, email_from, email_subject, email_body2, attachments

%><response><result>Request Sent</result></response>