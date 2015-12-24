<%
'###############################################
'# 
'# dbcommon_mdl.inc
'# 
'# Assign database connection to Moodle to conn_mdl
'# 
%>
<%
Set conn_mdl = Server.CreateObject("ADODB.Connection")
conn_mdl.ConnectionTimeout=500
conn_mdl.CommandTimeout=500
conn_mdl.Open  "DSN=Moodle;UID=root;PW=Destiny7;DATABASE=moodle", "root", "Destiny7"
%>
