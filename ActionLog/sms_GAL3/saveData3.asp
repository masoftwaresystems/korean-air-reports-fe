<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include file ="includes/wrapformdata2.inc"-->
<%
tmplinks		= request("links")
log_number		= request("log_number")

tmplinksArr		= split(tmplinks,",")

sql = "delete from SRT_Links where primary_log_number = "& sqlnum(log_number) &" and archived = 'n'"
conn_asap.execute(sql)

sql = "delete from SRT_Links where secondary_log_number = "& sqlnum(log_number) &" and archived = 'n'"
conn_asap.execute(sql)

for a = 0 to ubound(tmplinksArr)

  sql = "insert into SRT_Links (primary_log_number, secondary_log_number) values ("& sqlnum(log_number) &","& sqlnum(tmplinksArr(a)) &")"
  conn_asap.execute(sql)

  sql = "insert into SRT_Links (primary_log_number, secondary_log_number) values ("& sqlnum(tmplinksArr(a)) &","& sqlnum(log_number) &")"
  conn_asap.execute(sql)

next

divisionArr		= split(request("division"),",")

sql = "delete from SRT_LogNumberDivisions where log_number = "& sqlnum(log_number) &" and archived = 'n'"
conn_asap.execute(sql)

for a = 0 to ubound(divisionArr)

  sql = "insert into SRT_LogNumberDivisions (log_number, division) values ("& sqlnum(log_number) &","& sqltext2(trim(divisionArr(a))) &")"
  conn_asap.execute(sql)

next

pageArg = "?log_number="& log_number

response.redirect request("resultPage") & pageArg
response.end
%>