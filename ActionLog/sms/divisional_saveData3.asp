<!--#include file="includes/security.inc" -->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include virtual ="/global_includes/emailUtils.inc"-->
<% if(request("saveonexit") = "y") then %>
<!--#include file ="includes/wrapformdata2.inc"-->
<% end if %>
<%
tmplinks		= request("links")
log_number		= request("log_number")
viewDivision	= request("viewDivision")
position = request("position")

if(instr(request("resultPage"),"?") = 0) then
  pageArg = "?position="& position &"&log_number="& log_number &"&viewDivision="& viewDivision
end if

response.redirect request("resultPage") & pageArg
response.end
%>