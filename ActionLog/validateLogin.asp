<%
'response.redirect "action-log.aspx?rc=1"
%>
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<%
employee_number		= sqltext2(request("employee_number"))
password			= sqltext2(request("password"))

'if(employee_number <> "'maaron'") then
'  employee_number = sqltext2("bogus")
'end if

response.redirect "action-log.aspx?rc=1"
response.end

sql = "select loginID, username, srt_admin, employee_number, first_name, isnull(last_name,'') last_name, employee_type, division, email_address, srt_passwordchange, business_unit, basic_admin admin, sms_admin, base from Tbl_Logins where employee_number = "& employee_number &" and pw = "& password
'response.write(sql)
'response.end
set rs=conn_asap.execute(sql)
if not rs.EOF then
  'if(rs("srt_admin") = "y") then
    session.Timeout = 1440
    session("loginID") = rs("loginID")
  	response.cookies("loginID") = rs("loginID")
  	'response.cookies("validFMOLogin").domain = ".sanfrancisco.travel"

  	if((len(rs("last_name")) = 0) or (IsNull(rs("last_name")))) then
  	  tmplast_name = ""
  	else
  	  tmplast_name = rs("last_name")
  	end if

    session("srt_admin") = rs("srt_admin")
    session("employee_number") = rs("employee_number")
    response.cookies("employee_number") = rs("employee_number")
    session("username") = rs("username")
    response.cookies("username") = rs("username")
    session("division") = rs("division")
    response.cookies("division") = rs("division")
    session("first_name") = rs("first_name")
    response.cookies("first_name") = rs("first_name")
    session("last_name") = tmplast_name
    response.cookies("last_name") = tmplast_name
    session("email_address") = rs("email_address")
    session("srt_passwordchange") = rs("srt_passwordchange")
    session("business_unit") = rs("business_unit")
    response.cookies("business_unit") = rs("business_unit")
    session("admin") = rs("admin")
    response.cookies("admin") = rs("admin")
    session("sms_admin") = rs("sms_admin")
    response.cookies("sms_admin") = rs("sms_admin")
    session("base") = rs("base")
    response.cookies("base") = rs("base")
    session("employee_type") = rs("employee_type")
    response.cookies("employee_type") = rs("employee_type")

    seeDivision = ""
    seeAll = ""
    editDivision = ""
    administrator = ""

    if(trim(rs("employee_type")) = "DOY/GOY") then
      'seeAll = "y"
    end if
    if(trim(rs("employee_type")) = "Executive Level") then
      editDivision = "y"
    end if
    if(trim(rs("employee_type")) = "OYP/OYI/OYE/OYS/OYA") then
      'seeAll = "y"
    end if
    if(trim(rs("employee_type")) = "Team Leader Level") then
      editDivision = "y"
    end if
    if(trim(rs("employee_type")) = "Administrator Level") then
      administrator = "y"
    end if
    if(trim(rs("employee_type")) = "SELOY") then
      'seeAll = "y"
    end if
    if(trim(rs("employee_type")) = "General User Level") then
      editDivision = "y"
      seeDivision = "y"
    end if
    if(trim(rs("employee_type")) = "Primary User Level") then
      editDivision = "y"
      seeDivision = "y"
    end if


    if(trim(rs("employee_type")) = "High Level") then
      seeAll = "y"
    end if
    if(trim(rs("employee_type")) = "Low Level") then
      editDivision = "y"
      seeDivision = "y"
    end if

    session("seeDivision") = seeDivision
    response.cookies("seeDivision") = seeDivision
    session("seeAll") = seeAll
    response.cookies("seeAll") = seeAll
    session("editDivision") = editDivision
    response.cookies("editDivision") = editDivision
    session("administrator") = administrator
    response.cookies("administrator") = administrator

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
	location = "splash.aspx"
        'location = "admin_LogDisplay.asp"
      end if
    end if

    if(rs("srt_passwordchange") <> "n") then
      'location = "changePassword.asp"
    end if

  'else
  '  location = "index.asp?rc=2"
  'end if
else
  location = "action-log.aspx?rc=1"
end if

'response.write(location)
response.redirect location
response.end
%>