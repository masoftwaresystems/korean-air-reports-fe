<%
'###############################################
'#
'# createLogin.asp
'#
'# Creates a login within the SMS system and sends an email to the requesting user as to created or denied.
'#
%>
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/emailUtils.inc"-->
<%
employee_number		= request("employee_number")
first_name			= request("first_name")
last_name			= request("last_name")
division			= request("division")
access_level		= request("access_level")
email_address		= request("email_address")
phone_number		= request("phone_number")
reason				= request("reason")
status				= request("status2")
password			= request("password")
user_note			= request("user_note")
recid				= request("recid")

'response.write("status:"&request("status2"))
'response.end
%>
<%
'###############################################
'# Sets status of approval
'#
%>
<%
sql = "update SRT_LoginRequests set status = "& sqltext2(status) &", modify_date = getDate(), modify_user = "& sqltext2(session("employee_number")) &" where recid = "& sqlnum(recid)
conn_asap.execute(sql)

%>
<%
'###############################################
'# Creation of SMS login
'#
%>
<%
if(status = "APPROVED") then
  sql = "insert into Tbl_Logins (pw, first_name, last_name, employee_number, email_address, phone_number, createDate, division, srt_admin, srt_passwordchange) values ("& sqltext2(password) &","& sqltext2(first_name) &","& sqltext2(last_name) &","& sqltext2(employee_number) &","& sqltext2(email_address) &","& sqltext2(phone_number) &", getDate(),"& sqltext2(division) &","& sqltext2(access_level) &", 'y')"
  conn_asap.execute(sql)
end if

%>
<%
'###############################################
'# Create and send email
'#
%>
<%
body = ""
if(status = "APPROVED") then
  body = body& "Your request for an SMS login has been approved.<br>"
  body = body& "Please go to <a href='https://deltaflightsafety.com/sms'>https://deltaflightsafety.com/sms</a> to login.<br>"
  body = body& "<br>Your username: "& employee_number &"<br>"
  body = body& "<br>Your password: "& password &"<br>"
else
  body = body& "Your request for an SMS login has been denied.<br>"
end if

body = body& "<br>"& user_note

email_to = email_address
email_cc = "renny.hart@delta.com,alex.vargas@delta.com"
email_bcc = "mike.aaron@gmail.com"
email_from = ""
email_subject = "SMS Login Request ("& left(first_name,1) &" "& last_name &") - "& status

'sendEmail email_to, email_cc, email_bcc, email_from, email_subject, body

location = "loginRequest_final.asp?status="& status &"&email_address="& email_address

response.redirect location
response.end
%>
