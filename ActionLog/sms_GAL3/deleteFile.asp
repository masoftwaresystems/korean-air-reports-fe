<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<%
log_number		= request("log_number")
recid			= request("recid")

sql = "delete from EHD_Attachments where recid = "& sqlnum(recid)
conn_asap.execute(sql)

location = "iEHD_Attachments.asp?log_number="& log_number

response.redirect(location)
response.end
%>
%>