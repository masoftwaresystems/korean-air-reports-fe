<%
'###############################################
'#
'# admin_saveData3.asp
'#
'# Save iSRT data
'#
%>
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include file ="includes/wrapformdata2.inc"-->
<!--#include file ="includes/propogate.inc"-->
<%
position = request("position")
log_number = request("log_number")
resultPage = request("resultPage")
if(resultPage = "admin_LogInput.asp") then
    pageArg = "?log_number="& log_number &"&position="& position &"&viewDivision="& viewDivision
else
    pageArg = "?position="& position &"&viewDivision="& viewDivision
end if

response.redirect request("resultPage") & pageArg
response.end
%>
