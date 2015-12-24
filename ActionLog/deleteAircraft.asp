<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<%
aircraft		= request("aircraft")

sql = "delete from aircraft_t where aircraft = "& sqltext2(aircraft)
conn_asap.execute(sql)

location = "admin_aircraft.asp"
response.redirect(location)
response.end
%>