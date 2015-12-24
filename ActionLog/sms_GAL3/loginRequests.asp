<!--#include file ="includes/nocache.inc"-->
<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#INCLUDE FILE = "includes/dbcommon.inc" (conn) -->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include file ="includes/lockMgr.inc"-->
<%
unlockLogs
%>
<html>
<head>
<!--#include file ="includes/commonhead.inc"-->
<link href="styles/display.css" rel="stylesheet" type="text/css" />
<link href="css/style.css" rel="stylesheet" type="text/css" />
<!--#include file="script/nav.js"-->
</head>
<body >
<form name="frm" action="" method="post">

<center>
<!--#include file="includes/sms_header.inc"-->

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:20px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;">Login Requests</span></td></tr>
</table>

<% if(len(msg) > 0) then %>
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:10px;color:red;font-weight:bold;"><%= msg %></span></td></tr>
</table>
<% end if %>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="300" height="1"></td></tr>
</table>

<table border="0" cellspacing="5" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;padding-bottom:0px;margin-bottom:50px">
<%
sql = "select * from srt_loginrequests where status = 'PENDING' order by request_date asc"
set rs=conn_asap.execute(sql)
do while not rs.eof
  recid = rs("recid")
  first_name = rs("first_name")
  last_name = rs("last_name")
  employee_number = rs("employee_number")
  division = rs("division")
%>
  <tr>
    <td width="30%" align="right"><span class="fonts1" style="color:#737579;font-weight:bold;">&middot;</span></td>
    <td width="70%" align="left"><span class="fonts1" style="font-weight:bold;font-size:11px;"><a href="loginRequest.asp?recid=<%= recid %>"><%= first_name %>&nbsp;<%= last_name %>&nbsp;[<%= employee_number %>]&nbsp;::&nbsp;<%= division %></a></span></td>
  </tr>
<%
  rs.movenext
loop
%>
</table>




<!--#include file ="includes/footer.inc"-->

</center>
</form>
</body>
</html>
