<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include virtual ="/global_includes/emailUtils.inc"-->
<%
log_number			= request("log_number")

sql = "update EHD_Data set archived = 'y', modifyDate = getDate(), modifyUser = "& sqltext2(session("employee_number")) &" where logNumber = "& sqlnum(log_number)
conn_asap.execute(sql)

sql = "update EHD_Attachments set archived = 'y' where log_number = "& sqlnum(log_number)
conn_asap.execute(sql)

sql = "update SRT_Links set archived = 'y' where (primary_log_number = "& sqlnum(log_number) &" or secondary_log_number = "& sqlnum(log_number) &")"
conn_asap.execute(sql)

sql = "update SRT_LogNumberDivisions set archived = 'y' where log_number = "& sqlnum(log_number)
conn_asap.execute(sql)


location = "iSRT_LogDisplay.asp"
response.redirect location
response.end

%>