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

response.redirect "index.asp"
response.end
%>