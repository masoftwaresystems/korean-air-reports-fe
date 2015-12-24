<%
'###############################################
'# admin_deleteFile.asp
'#
'# Deletes files by way of archiving them for the iSRT area
'#
%>
<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<%
log_number		= request("log_number")
recid			= request("recid")
viewdivision	= request("viewdivision")

'sql = "delete from EHD_Attachments where recid = "& sqlnum(recid)
sql = "update EHD_Attachments set archived = 'y' where recid = "& sqlnum(recid)
conn_asap.execute(sql)

location = "admin_Attachments.asp?viewdivision="& viewdivision &"&log_number="& log_number

response.redirect(location)
response.end
%>
