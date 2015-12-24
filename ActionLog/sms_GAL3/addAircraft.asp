<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<%
aircraft		= request("aircraft")
description		= request("description")

sql = "insert into aircraft_t (aircraft, descript) values ("& sqltext2(aircraft) &","& sqltext2(description) &")"
conn_asap.execute(sql)

location = "admin_aircraft.asp"
response.redirect(location)
response.end
%>