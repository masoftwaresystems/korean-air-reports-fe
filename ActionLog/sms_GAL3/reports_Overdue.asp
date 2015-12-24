<!--#include file="includes/security.inc" -->
<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<%
unlockLogs
%>
<!--#include file="includes/sms_header.inc"-->
<center>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:20px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;">Overdue Hazard Reports</span></td></tr>
</table>

<% if(len(msg) > 0) then %>
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:10px;color:red;font-weight:bold;"><%= msg %></span></td></tr>
</table>
<% end if %>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="300" height="1"></td></tr>
</table>
<form name="frm" action="overdueReport.asp" method="get" target="_blank">
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><select class="fonts1" style="width:210px;font-size:13px;" name="risk"><option value="" selected>Risk - All</option><option value="Acceptable" >Risk - Acceptable</option><option value="Acceptable With Mitigation" >Risk - Acceptable With Mitigation</option>option value="Unacceptable" >Risk - Unacceptable</option></select></td></tr>
</table>
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><select class="fonts1" style="width:210px;font-size:13px;" name="division">
  <option value="" selected>Divisions - All</option>
<%
sql = "select distinct division, code from division_t order by division asc"
set rs=conn_asap.execute(sql)
do while not rs.eof
  tmpdivision = rs("division")
  tmpcode = rs("code")
%>
<option value="<%= tmpcode %>" ><%= tmpdivision %></option>
<%
  rs.movenext
loop
%>
  </select></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:10px;margin-left:10px;margin-bottom:50px">
  <tr><td align="center"><input type="submit" value="Create Report" style="font-size:10px;width:160px;font-weight:normal;height:20px;margin-top:0px;" onclick2="document.frm.submit()"></td></tr>
</table>
</form>

<!--#include file ="includes/footer.inc"-->

</center>
</body>
</html>
