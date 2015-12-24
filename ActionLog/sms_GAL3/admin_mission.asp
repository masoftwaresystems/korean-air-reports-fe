<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/security.inc" -->
<!--#include file="includes/dbcommon_asap.inc"-->
<!--#include file="includes/lockMgr.inc"-->
<%
unlockLogs
%>
<!--#include file="includes/sms_header.inc"-->
<script>
function deleteItem(m) {
  document.location = "deleteMission.asp?mission="+m;
}
</script>
<form name="frm" action="addMission.asp" method="post">

<center>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:20px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;">Admin Mission</span></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr><td align="center"><span class="fonts1" style="font-weight:bold;font-size:11px;"><input type="text" style="width:300px;color2:silver;" name="description" value="description" onfocus="this.select()"><br><input type="text" style="width:300px;color2:silver;" onfocus="this.select()" name="mission" value="code"><br><input type="submit" value="add new mission" style="font-size:10px;margin-right:5px;margin-left:5px;" onclick=""></td></tr>
</table>

<% if(len(msg) > 0) then %>
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:10px;color:red;font-weight:bold;"><%= msg %></span></td></tr>
</table>
<% end if %>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="370" height="1"></td></tr>
</table>

<table border="0" cellspacing="5" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;padding-bottom:0px;margin-bottom:50px">
<%
sql = "select distinct mission, description from mission order by mission asc"
set rs=conn_asap.execute(sql)
do while not rs.eof
  mission = rs("mission")
  description = rs("description")
%>
  <tr>
    <td width="30%" align="right"><span class="fonts1" style="color:#737579;font-weight:bold;"><input type="button" value="delete" style="font-size:8px;margin-right:5px;margin-left:5px;" onclick="deleteItem('<%= mission %>')"> &middot;</span></td>
    <td width="70%" align="left"><span class="fonts1" style="font-weight:bold;font-size:11px;"><%= description %> :: <span style="font-weight:normal"><%= mission %></span></span></td>
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
