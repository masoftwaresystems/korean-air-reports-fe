<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include file ="includes/wrapformdata2.inc"-->
<%
tmplinks		= request("links")
log_number		= request("log_number")

tmplinksArr		= split(tmplinks,",")

sql = "delete from iSRT_Links where primary_log_number = "& sqlnum(log_number) &" and archived = 'n'"
conn_asap.execute(sql)

for a = 0 to ubound(tmplinksArr)

  sql = "insert into iSRT_Links (primary_log_number, secondary_log_number) values ("& sqlnum(log_number) &","& sqlnum(tmplinksArr(a)) &")"
  conn_asap.execute(sql)

next

response.redirect "iSRT_LogInput.asp"
response.end
%>