<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include virtual="/global_includes/emailUtils.inc"-->
<%
username		= request("username")

sql = "SELECT * FROM Tbl_Logins where username = "& sqltext2(username)

'response.write(sql)
'response.end
set rs=conn_asap.execute(sql)
if not rs.EOF then

email_to = rs("email_address")
email_cc = ""
email_bcc = "support@masoftwaresystems.com"
email_subject = "Your SMAL Password"
email_body = "Password for username "& username &" : <b>"& rs("pw") &"</b>"
email_from = ""
sendEmail email_to, email_cc, email_bcc, email_from, email_subject, email_body

  foundStr = "true"
else
  foundStr = "false"
end if
%><rval><found><%= foundStr %></found></rval>