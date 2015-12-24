<%
'###############################################
'# 
'# admin_saveStageData.asp
'# 
'# Save iSRT stage data
'# 
%>
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include virtual ="/global_includes/wrapformdata_srtstage.inc"-->
<%
log_number		= request("log_number")
viewDivision	= request("viewDivision")
position = request("position")


pageArg = "?position="& position &"&log_number="& log_number &"&viewDivision=iSRT"

response.redirect request("resultPage") & pageArg
response.end
%>
