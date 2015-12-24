<%
'###############################################
'# admin_deleteLogNumber.asp
'#
'# Deletes log entries by way of archiving the log for the iSRT area.
'# Archives log number, attachments, links, and divisional log number mappings.
'#
%>
<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include virtual ="/global_includes/emailUtils.inc"-->
<%
log_number			= request("log_number")
viewdivision		= request("viewdivision")

sql = "update EHD_Data set archived = 'y', modifyDate = getDate(), modifyUser = "& sqltext2(session("employee_number")) &" where logNumber = "& sqlnum(log_number) &" and division = "& sqltext2(viewdivision)
conn_asap.execute(sql)

sql = "update EHD_Data set srtlognumber = null where srtlognumber = "& sqlnum(log_number) &" and division <> "& sqltext2(viewdivision)
conn_asap.execute(sql)

sql = "update EHD_Attachments set archived = 'y' where log_number = "& sqlnum(log_number) &" and division = "& sqltext2(viewdivision)
conn_asap.execute(sql)

sql = "update SRT_Links set archived = 'y' where (primary_log_number = "& sqlnum(log_number) &" or secondary_log_number = "& sqlnum(log_number) &") and division = "& sqltext2(viewdivision)
conn_asap.execute(sql)

sql = "delete from EHD_Item_Map where srt_log_number = "& sqlnum(log_number)
conn_asap.execute(sql)

'sql = "update SRT_LogNumberDivisions set archived = 'y' where log_number = "& sqlnum(log_number)
'conn_asap.execute(sql)


location = "admin_LogDisplay.asp?viewdivision="& viewdivision
response.redirect location
response.end

%>