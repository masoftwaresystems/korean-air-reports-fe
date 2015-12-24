<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<%
username			= sqltext2(request("username"))
password			= sqltext2(request("password1"))
first_name			= sqltext2(request("first_name"))
last_name			= sqltext2(request("last_name"))
employee_number		= sqltext2(request("employee_number"))
email_address		= sqltext2(request("email_address"))
phone_number		= sqltext2(request("phone_number"))
division			= sqltext2(request("division"))
best_contact		= sqltext2(request("best_contact"))

sql = "select loginID from Tbl_Logins where employee_number = "& employee_number
set rs=conn_asap.execute(sql)
if not rs.EOF then
  'location = "newlogin.asp?rc=2&username="& request("username") &"&first_name="& request("first_name") &"&last_name="& request("last_name") &"&employee_number="& request("employee_number") &"&email_address="& request("email_address") &"&phone_number="& request("phone_number") &"&employee_type="& request("employee_type") &"&best_contact="& request("best_contact")
  sql = "update Tbl_Logins set first_name = "& first_name &", last_name = "& last_name &", email_address = "& email_address &", phone_number = "& phone_number &", division = "& division &", best_contact = "& best_contact &" where employee_number = "& employee_number
  conn_asap.execute(sql)
  loginID = rs("loginID")
  session("loginID") = loginID
  session("username") = request("username")
  session("employee_number") = request("employee_number")
  session("division") = request("division")
  session("first_name") = request("first_name")
  session("last_name") = request("last_name")
else
  sql = "set NOCOUNT on;insert into Tbl_Logins (username, pw, first_name, last_name, employee_number, email_address, phone_number, division, best_contact) values ("& username &", "& password &", "& first_name &", "& last_name &", "& employee_number &", "& email_address &", "& phone_number &", "& division &", "& best_contact &");select @@IDENTITY as loginID;"
  set rs2=conn_asap.execute(sql)
  if not rs2.EOF then
    loginID = rs2("loginID")
  end if
  rc = 1
  session("loginID") = loginID
  session("username") = request("username")
  session("employee_number") = request("employee_number")
  session("division") = request("division")
  session("first_name") = request("first_name")
  session("last_name") = request("last_name")
end if

location = "divisional_LogDisplay.asp"

response.redirect location
response.end
%>
