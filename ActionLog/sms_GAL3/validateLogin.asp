<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<%
employee_number		= sqltext2(request("employee_number"))
password			= sqltext2(request("password"))

'if(employee_number <> "'maaron'") then
'  employee_number = sqltext2("bogus")
'end if

sql = "select loginID, username, srt_admin, employee_number, first_name, last_name, employee_type, division, email_address, srt_passwordchange, business_unit, basic_admin admin, sms_admin, base from Tbl_Logins where employee_number = "& employee_number &" and pw = "& password
set rs=conn_asap.execute(sql)
if not rs.EOF then
  'if(rs("srt_admin") = "y") then
    session.Timeout = 1440
    session("loginID") = rs("loginID")
    session("srt_admin") = rs("srt_admin")
    session("employee_number") = rs("employee_number")
    session("username") = rs("username")
    session("division") = rs("division")
    session("first_name") = rs("first_name")
    session("last_name") = rs("last_name")
    session("email_address") = rs("email_address")
    session("srt_passwordchange") = rs("srt_passwordchange")
    session("business_unit") = rs("business_unit")
    session("admin") = rs("admin")
    session("sms_admin") = rs("sms_admin")
    session("base") = rs("base")

    sql = "select code from BUtoBASE where business_unit = "& sqltext2(rs("business_unit")) &" and current_base = "& sqltext2(rs("base"))
    set tmprs = conn_asap.execute(sql)
    if not tmprs.eof then
      session("hazard_base") = tmprs("code")
    end if

    if((rs("division") = "") or (isnull(rs("division")))) then
      location = "updateProfile.asp?rc=3"
    else
      if((rs("srt_admin") = "w") or (rs("srt_admin") = "l") or (rs("srt_admin") = "p")) then
	location = "splash.asp"
        'location = "divisional_LogDisplay.asp?viewdivision="& rs("division")
      else
	location = "splash.asp"
        'location = "admin_LogDisplay.asp"
      end if
    end if

    if(rs("srt_passwordchange") <> "n") then
      location = "changePassword.asp"
    end if

  'else
  '  location = "index.asp?rc=2"
  'end if
else
  location = "index.asp?rc=1"
end if

'response.write(location)
response.redirect location
response.end
%>