<!--#include file ="includes/security.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include file ="includes/wrapformdata2.inc"-->
<%

log_number			= request("log_number")
log_numberStr		= string(4-len(log_number),"0")&log_number

viewDivision			= request("viewDivision")

pageArg = "?position="& position &"&log_number="& log_number &"&viewDivision="& viewDivision

response.redirect "divisional_risk2.aspx" & pageArg
response.end
%>
