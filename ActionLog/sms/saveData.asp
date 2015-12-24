<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include file ="includes/wrapformdata2.inc"-->
<%

if(request("get_max_recid") = "y") then
  sql = "select max(recid) recid from EHD_Data where logNumber = "& sqlnum(request("log_number"))
  set rs = conn_asap.execute(sql)
  if not rs.eof then
    pageArg = "?recid="& rs("recid")
  end if
end if

response.redirect request("resultPage") & pageArg
response.end
%>