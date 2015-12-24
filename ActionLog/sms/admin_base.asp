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
function deleteItem(b,bu) {
  document.location = "deleteBase.asp?base="+b+"&bu="+bu;
}
</script>
<form name="frm" action="addBase.asp" method="post">

<center>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:20px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;">Admin Base</span></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr><td align="center"><span class="fonts1" style="font-weight:bold;font-size:11px;"><input type="text" style="width:300px;" name="base" value="enter base name" onfocus="this.value=''"><br>
            <select style="width:305px;" name="bu">
              <option value="">select business unit</option>
              <option value="EBU">EBU</option>
              <option value="IBU">IBU</option>
              <option value="NABU">NABU</option>
              <option value="COBU">COBU</option>
              <option value="WASBU">WASBU</option>
              <option value="AUSBU">AUSBU</option>
              <option value="BA">BA</option>
              <option value="TEST">TEST</option>
            </select>
  <br><input type="text" style="width:300px;" name="base_code" value="enter base code" onfocus="this.value=''"><br><input type="submit" value="add new base" style="font-size:10px;margin-right:5px;margin-left:5px;" onclick=""></td></tr>
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
sql = "select distinct CURRENT_BASE, BUSINESS_UNIT, Code from BUtoBASE where BUSINESS_UNIT in ('EBU','IBU','NABU','COBU','WASBU','AUSBU') order by CURRENT_BASE asc"
set rs=conn_asap.execute(sql)
do while not rs.eof
  base = rs("CURRENT_BASE")
  bu = rs("BUSINESS_UNIT")
  base_code = rs("Code")
%>
  <tr>
    <td width="30%" align="right"><span class="fonts1" style="color:#737579;font-weight:bold;"><input type="button" value="delete" style="font-size:8px;margin-right:5px;margin-left:5px;" onclick="deleteItem('<%= base %>','<%= bu %>')"> &middot;</span></td>
    <td width="70%" align="left"><span class="fonts1" style="font-weight:bold;font-size:11px;"><%= base %> :: <span style="font-weight:normal;"><%= base_code %></span> :: <%= bu %></span></td>
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
