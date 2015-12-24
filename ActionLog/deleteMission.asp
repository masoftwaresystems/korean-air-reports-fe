<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<%
mission		= request("mission")

sql = "delete from mission where mission = "& sqltext2(mission)
conn_asap.execute(sql)

location = "admin_mission.asp"
response.redirect(location)
response.end
%>