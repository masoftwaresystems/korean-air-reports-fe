<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<%
sql = "select count(*) cnt from EHD_Comments where EHD_Comments.division = 'AERO' and log_number = 0077 and comment_type = 'attachments' order by recid desc"
set rs = conn_asap.execute(sql)
if not rs.eof then
%>
cnt:<%= rs("cnt") %>
<%
end  if
%>
<%
set oUpload = server.createobject("Persits.Upload")
response.end
%>
<%
sql = "select loginID, username, srt_admin, employee_number, first_name, NVL(last_name,'') last_name, employee_type, division, email_address, srt_passwordchange, business_unit, basic_admin admin, sms_admin, base from Tbl_Logins where employee_number = '0006672'"
set rs = conn_asap.execute(sql)
do while not rs.eof
%>
last_name:<%= IsNull(rs("last_name")) %>:<br>
<br>
<%
  rs.movenext
loop
response.end
%>
<%
sql = "update Tbl_Logins set division = 'OPSCTRL' where division = 'OPS CTRL'"
conn_asap.execute(sql)
response.end
%>
<%
sql = "select * from EHD_Data where division = 'AERO' order by logNumber asc"
set rs = conn_asap.execute(sql)
do while not rs.eof
%>
iSRT_LogInput:<%= rs("formName") %>:<br>
active:<%= rs("active") %>:<br>
archived:<%= rs("archived") %>:<br>
logNumber:<%= rs("logNumber") %>:<br>
hazard_number:<%= rs("hazard_number") %>:<br>
CREATEDATE:<%= rs("CREATEDATE") %>:<br>
formDataXML:<%= rs("formDataXML") %>:<br>
<br>
<%
  rs.movenext
loop
response.end
%>
<%
sql = "select distinct division from EHD_Data where formName = 'iSRT_LogInput' and active = 'y' and archived = 'n' "
set rs = conn_asap.execute(sql)
do while not rs.eof
%>
division:<%= rs("division") %>:<br>
<br>
<%
  rs.movenext
loop
response.end
%>
<%
sql = "update Tbl_Logins set basic_admin = 'n' where basic_admin is null"
conn_asap.execute(sql)
response.end
%>
<%
sql = "update Tbl_Logins set pw = '12345' where loginID = 114"
conn_asap.execute(sql)
response.end
%>
<%
sql = "select loginID, first_name, last_name, pw, basic_admin, sms_admin, email_address from Tbl_Logins order by loginID asc"
set rs = conn_asap.execute(sql)
do while not rs.eof
%>
loginID:<%= rs("loginID") %>:<br>
first_name:<%= rs("first_name") %>:<br>
last_name:<%= rs("last_name") %>:<br>
pw:<%= rs("pw") %>:<br>
basic_admin:<%= rs("basic_admin") %>:<br>
sms_admin:<%= rs("sms_admin") %>:<br>
email_address:<%= rs("email_address") %>:<br>
<br>
<%
  rs.movenext
loop
response.end
%>
<%
sql = "update Tbl_Logins set pw = 'maaron' where loginID = 114"
conn_asap.execute(sql)
response.end
%>
<%
sql = "select loginID, first_name, last_name, pw, basic_admin, sms_admin from Tbl_Logins order by loginID asc"
set rs = conn_asap.execute(sql)
do while not rs.eof
%>
loginID:<%= rs("loginID") %>:<br>
first_name:<%= rs("first_name") %>:<br>
last_name:<%= rs("last_name") %>:<br>
pw:<%= rs("pw") %>:<br>
basic_admin:<%= rs("basic_admin") %>:<br>
sms_admin:<%= rs("sms_admin") %>:<br>
<%
  rs.movenext
loop
response.end
%>
<%
sql = "select distinct station from station_t order by station asc"
set rs = conn_asap.execute(sql)
do while not rs.eof
%>
division:<%= rs("station") %>:<br>
<%
  rs.movenext
loop
response.end
%>
<%
sql = "select * from EHD_Comments"
set rs = conn_asap.execute(sql)
do while not rs.eof
%>
comment_ehd:<%= rs("comment_ehd") %>:<br>
comment_type:<%= rs("comment_type") %>:<br>
log_number:<%= rs("log_number") %>:<br>
division:<%= rs("division") %>:<br>
<%
  rs.movenext
loop
response.end
%>
<%
sql = "select * from EHD_Data where logNumber is not null"
set rs = conn_asap.execute(sql)
do while not rs.eof
%>
division:<%= rs("division") %>:<br>
logNumber:<%= rs("logNumber") %>:<br>
hazard_number:<%= rs("hazard_number") %>:<br>
<%
  rs.movenext
loop
response.end
%>
<%
sql = "select logNumber from EHD_Data where division = 'AERO' and hazard_number = 0002"
set rs = conn_asap.execute(sql)
do while not rs.eof
%>
logNumber:<%= rs("logNumber") %>:<br>
<%
  rs.movenext
loop
response.end
%>
<%
sql = "delete from EHD_data where logNumber is null"
conn_asap.execute(sql)
response.end
%>
<%
sql = "select * from EHD_Data where logNumber is not null"
set rs = conn_asap.execute(sql)
do while not rs.eof
%>
division:<%= rs("division") %>:<br>
logNumber:<%= rs("logNumber") %>:<br>
hazard_number:<%= rs("hazard_number") %>:<br>
<%
  rs.movenext
loop
response.end
%>
<div>
<img src="http://www.bristowsafety.com/images/1pred.png" height="100" width="100">
</div>
<%
sql = "delete from SRT_Locks"
conn_asap.execute(sql)
response.end
%>
<%
sql = "update tbl_logins set business_unit = 'AERO', base = 'AERO', division = 'AERO' where loginID = 1"
conn_asap.execute(sql)
response.end
%>
<%
sql = "select * from EHD_Data where formname = 'iSRT_LogInput' and logNumber = 0001 and division = 'AERO' and active ='y' order by logNumber desc, recid desc"
set rs = conn_asap.execute(sql)
do while not rs.eof
%>
base:<%= rs("base") %>:<br>
<%
  rs.movenext
loop
%>
<%
response.end
sql = "insert into tbl_logins (loginID," & _
"username, " & _
"pw," & _
"first_name," & _
"last_name," & _
"employee_number," & _
"email_address," & _
"basic_admin," & _
"amt_admin," & _
"division," & _
"srt_admin," & _
"srt_passwordchange," & _
"business_unit," & _
"base," & _
"createDate," & _
"lastLogin," & _
"sms_admin)" & _
"values " & _
"(1," & _
"'maaron'," & _
"'12345'," & _
"'Mike'," & _
"'Aaron'," & _
"'maaron'," & _
"'mike.aaron@gmail.com'," & _
"'y'," & _
"'n'," & _
"'EBU'," & _
"'n'," & _
"'n'," & _
"'EBU'," & _
"'Aberdeen'," & _
"current_date," & _
"current_date," & _
"'y')"
response.write(sql)
'conn_asap.execute(sql)
%>Done