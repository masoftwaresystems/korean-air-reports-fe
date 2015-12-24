<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include virtual ="/global_includes/emailUtils.inc"-->
<%
log_number			= request("log_number")
viewdivision		= request("viewdivision")

'response.write("log_number:"& log_number &"<br>")
'response.write("viewdivision:"& viewdivision &"<br>")
'response.end

sql = "update EHD_Data set archived = 'y', modifyDate = CURDATE(), modifyUser = "& sqltext2(session("employee_number")) &" where logNumber = "& sqlnum(log_number) &" and division = "& sqltext2(viewdivision)
conn_asap.execute(sql)

sql = "update EHD_Attachments set archived = 'y' where log_number = "& sqlnum(log_number) &" and division = "& sqltext2(viewdivision)
conn_asap.execute(sql)

sql = "update SRT_Links set archived = 'y' where (primary_log_number = "& sqlnum(log_number) &" or secondary_log_number = "& sqlnum(log_number) &") and division = "& sqltext2(viewdivision)
conn_asap.execute(sql)

sql = "delete from EHD_Item_Map where division = "& sqltext2(viewdivision) &" and divisional_log_number = "& sqlnum(log_number)
conn_asap.execute(sql)

'sql = "update SRT_LogNumberDivisions set archived = 'y' where log_number = "& sqlnum(log_number)
'conn_asap.execute(sql)


location = "divisional_LogDisplay.asp?viewdivision="& viewdivision
response.redirect location
response.end

%>