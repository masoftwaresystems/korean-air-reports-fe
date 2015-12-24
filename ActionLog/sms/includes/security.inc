<%
if((request("cookie_loginID") = "") and (session("loginID") = "") and (Request.Cookies("loginID") = "")) then
  response.redirect "index.aspx"
  response.end
end if


session_loginID = request("cookie_loginID")
if(session_loginID = "") then
  session_loginID = session("loginID")
end if
if(session_loginID = "") then
  session_loginID = Request.Cookies("loginID")
end if

session_employee_number = request("cookie_employee_number")
if(session_employee_number = "") then
  session_employee_number = session("employee_number")
end if
if(session_employee_number = "") then
  session_employee_number = Request.Cookies("employee_number")
end if

session_username = request("cookie_username")
if(session_username = "") then
  session_username = session("username")
end if
if(session_username = "") then
  session_username = Request.Cookies("username")
end if

session_division = request("cookie_division")
if(session_division = "") then
  session_division = session("division")
end if
if(session_division = "") then
  session_division = Request.Cookies("division")
end if

session_first_name = request("cookie_first_name")
if(session_first_name = "") then
  session_first_name = session("first_name")
end if
if(session_first_name = "") then
  session_first_name = Request.Cookies("first_name")
end if

session_last_name = request("cookie_last_name")
if(session_last_name = "") then
  session_last_name = session("last_name")
end if
if(session_last_name = "") then
  session_last_name = Request.Cookies("last_name")
end if

session_email_address = request("cookie_email_address")
if(session_email_address = "") then
  session_email_address = session("email_address")
end if
if(session_email_address = "") then
  session_email_address = Request.Cookies("email_address")
end if

session_business_unit = request("cookie_business_unit")
if(session_business_unit = "") then
  session_business_unit = session("business_unit")
end if
if(session_business_unit = "") then
  session_business_unit = Request.Cookies("business_unit")
end if

session_sms_admin = request("cookie_sms_admin")
if(session_sms_admin = "") then
  session_sms_admin = session("sms_admin")
end if
if(session_sms_admin = "") then
  session_sms_admin = Request.Cookies("sms_admin")
end if

session_admin = request("cookie_admin")
if(session_admin = "") then
  session_admin = session("admin")
end if
if(session_admin = "") then
  session_admin = Request.Cookies("admin")
end if

session_base = request("cookie_base")
if(session_base = "") then
  session_base = session("base")
end if
if(session_base = "") then
  session_base = Request.Cookies("base")
end if
%>