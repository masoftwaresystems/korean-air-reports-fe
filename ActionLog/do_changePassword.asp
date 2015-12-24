<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<%
password		= request("password")

sql = "update Tbl_Logins set pw = "& sqltext2(password) &", srt_passwordchange = 'n' where username = "& sqltext2(session("username"))
'response.write(sql)
'response.end
conn_asap.execute(sql)

session("srt_passwordchange") = "n"

'if((session("srt_admin") = "w") or (session("srt_admin") = "l")) then
'  location = "divisional_LogDisplay.asp?viewdivision="& session("division")
'else
'  location = "admin_LogDisplay.asp"
'end if
location = "splash.asp"

response.redirect location
response.end
%>
