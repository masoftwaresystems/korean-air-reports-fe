<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<%
base		= request("base")
bu			= request("bu")
base_code	= request("base_code")

sql = "insert into BUtoBASE (CURRENT_BASE, BUSINESS_UNIT, Code) values ("& sqltext2(base) &","& sqltext2(bu) &","& sqltext2(base_code) &")"
conn_asap.execute(sql)

location = "admin_base.asp"
response.redirect(location)
response.end
%>