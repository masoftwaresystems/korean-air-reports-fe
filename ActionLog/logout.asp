<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include file="showVars.inc"-->
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

response.cookies("loginID") = ""
session("loginID") = ""
session("srt_admin") = ""
response.cookies("srt_admin") = ""
session("employee_number") = ""
response.cookies("employee_number") = ""
session("username") = ""
response.cookies("username") = ""
session("division") = ""
response.cookies("division") = ""
session("first_name") = ""
response.cookies("first_name") = ""
session("last_name") = ""
response.cookies("last_name") = ""
session("email_address") = ""
session("srt_passwordchange") = ""
session("business_unit") = ""
response.cookies("business_unit") = ""
session("admin") = ""
response.cookies("admin") = ""
session("sms_admin") = ""
response.cookies("sms_admin") = ""
session("base") = ""
response.cookies("base") = ""
session("employee_type") = ""
response.cookies("employee_type") = ""
session("seeDivision") = ""
response.cookies("seeDivision") = ""
session("seeAll") = ""
response.cookies("seeAll") = ""
session("editDivision") = ""
response.cookies("editDivision") = ""
session("administrator") = ""
response.cookies("administrator") = ""

session("hazard_base") = ""
session.abandon

'response.end
response.redirect "index.aspx"
response.end
%>