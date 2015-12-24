<%
Set conn_asap = Server.CreateObject("ADODB.Connection")
conn_asap.ConnectionTimeout=500
conn_asap.CommandTimeout=500
conn_asap.Open  "DSN=Bristow;UID=makinghistory;PW=h1st0ry;DATABASE=makinghistory", "makinghistory", "h1st0ry"
%>
