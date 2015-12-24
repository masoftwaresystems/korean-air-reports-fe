<!--#include file="includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<%
unlockLogs
%>
<%
if(request("logout") = "y") then
  session("loginID") = ""
  session("srt_admin") = ""
  session("username") = ""
  session("employee_number") = ""
  session("employee_type") = ""
  session("first_name") = ""
  session("last_name") = ""
  session("division") = ""
  session.abandon
end if

if(request("rc") = "1") then
  msg = "** Invalid Login **"
end if
if(request("rc") = "2") then
  msg = "** Not Administrator **"
end if
'msg = "** Down for Maintenance. Please check back shortly. **"
'disable_buttons = "disabled"
%>

<html>
<head>
<!--#include file ="includes/commonhead.inc"-->
<script>
function init() {
  frm.employee_number.focus();
}
</script>
</head>
<body onload="init()">
<form name="frm" action="validateLogin.asp" method="post">
<center>

<div style="margin-right:0px;margin-left:0px;">
  <table border="0" cellspacing="0" cellpadding="0" width="100%" style="padding-top:3px;margin-left:0px;margin-right:10px;">
    <tr valign="bottom">
      <td align="left" width="33%" style="padding-left:10px;padding-bottom:8px;padding-top:8px"></td>
      <td style="" align="center" width="33%" style="font-size:15px;font-weight:bold;padding-bottom:5px;font-color:#000040;" background="" bgColor="#ffffff">Action Log</td>
      <td align="right" width="33%" valign="bottom" style="padding-bottom:7px;padding-right:5px;"><span style="font-size:10px;color:#003366;font-weight:bold;">&nbsp;</span></td>
      <td width="1%">&nbsp;</td>
    </tr>
  </table>

  <table border="0" cellspacing="0" cellpadding="0" width="100%" style="padding-top:0px;margin-left:0px;margin-right:0px;">
    <tr><td align="center"><img src="images/1pblack.gif" width="98%" height="1"></td></tr>
  </table>
</div>

<% if(len(msg) > 0) then %>
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:10px;color:red;font-weight:bold;"><%= msg %></span></td></tr>
</table>
<% end if %>

<div style="padding-top:15px;width:550px" align="center">
<table style="background-color:#FFFFFF
                ;font: 10pt verdana;border-width:1;
        border-style:solid;border-color:black;"
        cellspacing=0 ID="Table1" width="300">
  <tr>
    <td colspan="2" height="30" align="center"><div class="title" style="background:#737579;color:white">Action Log Login</div></td>
  </tr>
  <tr>
    <td colspan="2" height="5"></td>
  </tr>
  <tr valign="top">
    <td align="right" class="label">Username :&nbsp;</td>
    <td><input name="employee_number" type="text" id="employee_number" class="input2" style="width:150px;border:1px solid black;" /></td>
  </tr>
  <tr>
    <td colspan="2" height="15"></td>
  </tr>
  <tr>
    <td align="right" class="label">Password : </td>
    <td><input name="password" type="password" id="password" class="input2" style="width:150px;border:1px solid black;" /></td>
  </tr>
  <tr>
    <td colspan="2" height="5"></td>
  </tr>
  <tr>
    <td></td>
    <td><input type="submit" name="" value="Login" class="fonts1" <%= disable_buttons %> /></td>
  </tr>
  <tr>
    <td colspan="2" height="5"></td>
  </tr>
</table>
</div>


<!--#include file ="includes/footer.inc"-->
</body>
</html>
