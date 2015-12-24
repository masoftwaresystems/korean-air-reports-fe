<!--#include virtual="/global_includes/nocache.inc"-->
<%
session("loginID") = ""
session("srt_admin") = ""
session("sms_admin") = ""
session("employee_number") = ""
session("username") = ""
session("division") = ""
session("first_name") = ""
session("last_name") = ""
session("email_address") = ""
session("srt_passwordchange") = ""
session("base") = ""
session("hazard_base") = ""
session.abandon

response.cookies("loginID") = ""
response.cookies("srt_admin") = ""
response.cookies("sms_admin") = ""
response.cookies("employee_number") = ""
response.cookies("username") = ""
response.cookies("division") = ""
response.cookies("first_name") = ""
response.cookies("last_name") = ""
response.cookies("email_address") = ""
response.cookies("srt_passwordchange") = ""
response.cookies("base") = ""
response.cookies("hazard_base") = ""

response.redirect "index.aspx"
response.end
%>