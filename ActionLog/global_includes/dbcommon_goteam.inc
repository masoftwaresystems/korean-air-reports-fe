<%
Set conn_gt = Server.CreateObject("ADODB.Connection")
conn_gt.ConnectionTimeout=500
conn_gt.CommandTimeout=500
conn_gt.Open  "Provider=SQLNCLI; Server=DELTAFLIGHTSAFE;DSN=goteam;UID=asapadmin;PW=fltsafety096;DATABASE=GoTeam", "asapadmin", "fltsafety096"
%>
