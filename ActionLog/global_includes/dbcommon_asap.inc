<%
'###############################################
'# 
'# dbcommon_asap.inc
'# 
'# Assign database connection to ASAP to conn_asap
'# 
%>
<%
Set conn_asap = Server.CreateObject("ADODB.Connection")
conn_asap.ConnectionTimeout=500
conn_asap.CommandTimeout=500
'conn_asap.Open "Provider=SQLNCLI; Server=70.85.189.26;DSN=Bristow2;UID=makinghistory;PW=h1st0ry;DATABASE=makinghistory", "makinghistory", "h1st0ry"
conn_asap.Open  "DSN=Bristow;UID=maaron;PW=Destiny7;DATABASE=safety", "maaron", "Destiny7"
%>
