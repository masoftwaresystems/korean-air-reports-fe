<%
if((request("cookie_loginID") = "") and (session("loginID") = "") and (Request.Cookies("loginID") = "")) then
  response.redirect "index.aspx"
  response.end
end if


session_loginID = request("cookie_loginID")
if((session_loginID = "") and (session("loginID") <> "")) then
  tmpArr = split(session("loginID"),",")
  session_loginID = trim(tmpArr(0))
end if
if((session_loginID = "") and (Request.Cookies("loginID") <> "")) then
  tmpArr = split(Request.Cookies("loginID"),",")
  session_loginID = trim(tmpArr(0))
end if

session_employee_number = request("cookie_employee_number")
if((session_employee_number = "") and (session("employee_number") <> "")) then
  tmpArr = split(session("employee_number"),",")
  session_employee_number = trim(tmpArr(0))
end if
if((session_employee_number = "") and (Request.Cookies("employee_number") <> "")) then
  tmpArr = split(Request.Cookies("employee_number"),",")
  session_employee_number = trim(tmpArr(0))
end if


session_username = request("cookie_username")
if((session_username = "") and (session("username") <> "")) then
  tmpArr = split(session("username"),",")
  session_username = trim(tmpArr(0))
end if
if((session_username = "") and (Request.Cookies("username") <> "")) then
  tmpArr = split(Request.Cookies("username"),",")
  session_username = trim(tmpArr(0))
end if


session_division = request("cookie_division")
if((session_division = "") and (session("division") <> "")) then
  tmpArr = split(session("division"),",")
  session_division = trim(tmpArr(0))
end if
if((session_division = "") and (Request.Cookies("division") <> "")) then
  tmpArr = split(Request.Cookies("division"),",")
  session_division = trim(tmpArr(0))
end if



session_first_name = request("cookie_first_name")
if((session_first_name = "") and (session("first_name") <> "")) then
  tmpArr = split(session("first_name"),",")
  session_first_name = trim(tmpArr(0))
end if
if((session_first_name = "") and (Request.Cookies("first_name") <> "")) then
  tmpArr = split(Request.Cookies("first_name"),",")
  session_first_name = trim(tmpArr(0))
end if


session_last_name = request("cookie_last_name")
if((session_last_name = "") and (session("last_name") <> "")) then
  tmpArr = split(session("last_name"),",")
  session_last_name = trim(tmpArr(0))
end if
if((session_last_name = "") and (Request.Cookies("last_name") <> "")) then
  tmpArr = split(Request.Cookies("last_name"),",")
  session_last_name = trim(tmpArr(0))
end if


session_email_address = request("cookie_email_address")
if((session_email_address = "") and (session("email_address") <> "")) then
  tmpArr = split(session("email_address"),",")
  session_email_address = trim(tmpArr(0))
end if
if((session_email_address = "") and (Request.Cookies("email_address") <> "")) then
  tmpArr = split(Request.Cookies("email_address"),",")
  session_email_address = trim(tmpArr(0))
end if


session_business_unit = request("cookie_business_unit")
if((session_business_unit = "") and (session("business_unit") <> "")) then
  tmpArr = split(session("business_unit"),",")
  session_business_unit = trim(tmpArr(0))
end if
if((session_business_unit = "") and (Request.Cookies("business_unit") <> "")) then
  tmpArr = split(Request.Cookies("business_unit"),",")
  session_business_unit = trim(tmpArr(0))
end if


session_sms_admin = request("cookie_sms_admin")
if((session_sms_admin = "") and (session("sms_admin") <> "")) then
  tmpArr = split(session("sms_admin"),",")
  session_sms_admin = trim(tmpArr(0))
end if
if((session_sms_admin = "") and (Request.Cookies("sms_admin") <> "")) then
  tmpArr = split(Request.Cookies("sms_admin"),",")
  session_sms_admin = trim(tmpArr(0))
end if


session_admin = request("cookie_admin")
if((session_admin = "") and (session("admin") <> "")) then
  tmpArr = split(session("admin"),",")
  session_admin = trim(tmpArr(0))
end if
if((session_admin = "") and (Request.Cookies("admin") <> "")) then
  tmpArr = split(Request.Cookies("admin"),",")
  session_admin = trim(tmpArr(0))
end if


session_base = request("cookie_base")
if((session_base = "") and (session("base") <> "")) then
  tmpArr = split(session("base"),",")
  session_base = trim(tmpArr(0))
end if
if((session_base = "") and (Request.Cookies("base") <> "")) then
  tmpArr = split(Request.Cookies("base"),",")
  session_base = trim(tmpArr(0))
end if

%>