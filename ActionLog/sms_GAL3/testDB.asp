<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
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