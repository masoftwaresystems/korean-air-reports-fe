<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<%
loginID		= request("loginID")

sql = "delete from Tbl_Logins where loginID = "& sqlnum(loginID)
conn_asap.execute(sql)

location = "admin_user.asp"
response.redirect(location)
response.end
%>