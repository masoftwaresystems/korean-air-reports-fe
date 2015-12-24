<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<%
username		= sqltext2(request("username"))
password			= sqltext2(request("password"))

sql = "select username, recid, fullname, email from bristow_emails where email = "& sqltext2(username )&" and password = "& sqltext2(password)
set rs=conn_asap.execute(sql)
if not rs.EOF then

    session.Timeout = 1440
    session("username") = rs("username")
    session("fullname") = rs("fullname")
    session("email") = rs("email")
    session("recid") = request("recid")

    response.cookies("username") = rs("username")
    response.cookies("fullname") = rs("fullname")
    response.cookies("email") = rs("email")
    response.cookies("recid") = request("recid")

   location = "safety-team.aspx"

else
  location = "login.aspx?rc=1"
end if


response.redirect location
response.end
%>