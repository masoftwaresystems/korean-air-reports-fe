<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<%
username			= sqltext2(request("username"))
password			= sqltext2(request("password1"))
first_name			= sqltext2(request("first_name"))
last_name			= sqltext2(request("last_name"))
employee_number		= sqltext2(request("employee_number"))
email_address		= sqltext2(request("email_address"))
phone_number		= sqltext2(request("phone_number"))
business_unit		= sqltext2(request("business_unit"))
loginID				= request("loginID")
division			= sqltext2(request("division"))
sms_admin			= sqltext2(request("sms_admin"))
base				= sqltext2(request("base"))

sql = "update Tbl_Logins set pw = "& password &" where loginID = "& loginID
rc = "2"
conn_asap.execute(sql)

location = "updateProfile2.asp?rc="& rc &"&loginID="& loginID &"&user="& request("user")
response.redirect location
response.end
%>