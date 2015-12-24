<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<%
base		= request("base")
bu			= request("bu")

sql = "delete from BUtoBASE where CURRENT_BASE = "& sqltext2(base) &" and BUSINESS_UNIT = "& sqltext2(bu)
conn_asap.execute(sql)

location = "admin_base.asp"
response.redirect(location)
response.end
%>