<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/emailUtils.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<%
employee_number		= request("employee_number")
first_name			= request("first_name")
last_name			= request("last_name")
division			= request("division")
access_level		= request("access_level")
email_address		= request("email_address")
phone_number		= request("phone_number")
reason				= request("reason")


sql = "set NOCOUNT on;insert into SRT_LoginRequests (employee_number, first_name, last_name, division, access_level, email_address, phone_number, reason, status) values ("& sqltext2(employee_number) &","& sqltext2(first_name) &","& sqltext2(last_name) &","& sqltext2(division) &","& sqltext2(access_level) &","& sqltext2(email_address) &","& sqltext2(phone_number) &","& sqltext2(reason) &", 'PENDING');select @@IDENTITY as recid;"
set rs=conn_asap.execute(sql)
if not rs.EOF then
  recid = rs("recid")
end if

body = ""
body = body& "Please log into <a href='https://deltaflightsafety.com/sms'>SMS</a> to view login request for "& first_name &" "& last_name &"."

email_to = "alex.vargas@delta.com"
email_cc = "renny.hart@delta.com"
email_bcc = "mike.aaron@gmail.com"
email_from = ""
email_subject = "SMS Login Request ("& left(first_name,1) &" "& last_name &")"

'sendEmail email_to, email_cc, email_bcc, email_from, email_subject, body

location = "requestLogin_thanks.asp"

response.redirect location
response.end
%>
