<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<%
if(session("administrator") <> "y") then
  response.end
end if

hazard_id = request("h")
hazard_idArr = split(hazard_id,"-")

division = hazard_idArr(0)
hazard_number = hazard_idArr(1)
'hazard_base = hazard_idArr(1)
'hazard_type = hazard_idArr(2)
'hazard_number = hazard_idArr(3)

sql = "select logNumber from EHD_Data where division = "& sqltext2(division) &" and hazard_number = "& sqlnum(hazard_number)
'response.write(sql)
'response.write("<br>")
set rs = conn_asap.execute(sql)
if not rs.eof then
  log_number = rs("logNumber")
end if

sql = "delete from EHD_Attachments where division = "& sqltext2(division) &" and log_number = "& sqlnum(log_number)
'response.write(sql)
'response.write("<br>")
'response.end
conn_asap.execute(sql)

sql = "delete from EHD_Comments where division = "& sqltext2(division) &" and log_number = "& sqlnum(log_number)
conn_asap.execute(sql)

sql = "delete from EHD_Data where division = "& sqltext2(division) &" and hazard_number = "& sqlnum(hazard_number)
'response.write(sql)
'response.write("<br>")
conn_asap.execute(sql)
'response.write(sql &"<br>")

'sql = "select current_base from BUtoBASE where business_unit = "& sqltext2(division) &" and code = "& sqltext2(hazard_base)
'set rs=conn_asap.execute(sql)
'if not rs.eof then
'  base = rs("current_base")
'end if
'response.write(sql &"<br>")

location = "divisional_Base.aspx?viewdivision="& division &"&viewtype=&base="& base
'response.write(location)
'response.end
response.redirect location
response.end
%>