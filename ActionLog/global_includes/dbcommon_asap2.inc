<%
Set conn_asap = Server.CreateObject("ADODB.Connection")
conn_asap.ConnectionTimeout=500
conn_asap.CommandTimeout=500
'conn_asap.Open  "Provider=OraOLEDB.Oracle.1;Data Source=SOPERAT;User Id=hazardaction;Password=actionlog02!;Persist Security Info=True;", "hazardaction", "actionlog02!"
'conn_asap.Open  "Provider=OraOLEDB.Oracle.1;Data Source=SOPERA;User Id=hazardaction;Password=actionlog06!;Persist Security Info=True;", "hazardaction", "actionlog06!"
conn_asap.Open  "DSN=mass_us;UID=mass_user;PW=massuser;DATABASE=maaron_us", "mass_user", "massuser"
%>