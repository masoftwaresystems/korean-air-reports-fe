<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<%
tmplinks		= request("links")
log_number		= request("log_number")
viewDivision	= request("viewDivision")
position = request("position")
%>
<!--#include file ="includes/copyGenericToBU.inc"-->
<%

pageArg = "?position="& position &"&log_number="& log_number &"&viewDivision="& viewDivision


response.redirect request("resultPage") & pageArg
response.end
%>