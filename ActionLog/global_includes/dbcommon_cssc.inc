<%
Set conn_cssc = Server.CreateObject("ADODB.Connection")
conn_cssc.ConnectionTimeout=500
conn_cssc.CommandTimeout=500
conn_cssc.Open  "Provider=SQLNCLI; Server=DELTAFLIGHTSAFE;DSN=cssc;UID=asapadmin;PW=fltsafety096;DATABASE=cssc", "asapadmin", "fltsafety096"
%>
