<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<%
mission		= request("mission")
description		= request("description")

sql = "insert into mission (mission, description) values ("& sqltext2(mission) &","& sqltext2(description) &")"
conn_asap.execute(sql)

location = "admin_mission.asp"
response.redirect(location)
response.end
%>