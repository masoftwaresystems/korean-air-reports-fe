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
base				= request("base")
if(base = "") then
  base = "|"
end if
if(base = "All") then
  base = "All|All"
end if
baseArr = split(base,"|")
base = baseArr(1)
base = sqltext2(base)
oldpassword			= sqltext2(request("oldpassword"))

if(oldpassword <> password) then
  changepassword = "'y'"
else
  changepassword = "'n'"
end if

if(division = "") then
  division = business_unit
end if

if(loginID = "") then
  sql = "insert into Tbl_Logins (username, pw, first_name, last_name, employee_number, email_address, phone_number, business_unit, division, basic_admin, srt_admin, sms_admin, base, srt_passwordchange) values ("& username &","& password &","& first_name &","& last_name &","& username &","& email_address &","& phone_number &","& business_unit &","& business_unit &",'y','y',"& sms_admin &","& base &","& changepassword &")"
  rc = "1"
else
  sql = "update Tbl_Logins set first_name = "& first_name &", last_name = "& last_name &", employee_number = "& username &", email_address = "& email_address &", phone_number = "& phone_number &", division = "& business_unit &", business_unit = "& business_unit &", pw = "& password &", username = "& username &", basic_admin = 'y', srt_admin = 'y', sms_admin = "& sms_admin &", base = "& base &", srt_passwordchange = "& changepassword &" where loginID = "& loginID
  rc = "2"
end if
'response.write(sql)
'response.end
conn_asap.execute(sql)

location = "updateProfile.asp?rc="& rc &"&loginID="& loginID &"&user="& request("user")
response.redirect location
response.end
%>