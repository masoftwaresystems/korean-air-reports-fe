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
<!--#INCLUDE virtual ="/fckeditor2/fckeditor.asp" -->
<%
base = request("base")
bu = request("bu")
rc = request("rc")

if(rc = "1") then
  msg = "Bulletin updated"
end if

sql = "select * from bullet_info_t order by timestmp desc"
set rs = conn_asap.execute(sql)
if not rs.eof then
  title = rs("title")
  subject = rs("subject")
  reporter = rs("reporter")
end if
%>
<form name="frm" method="post" action="updateNews.asp">
<script>
function changeBU(b) {
  //document.location = "editNews.asp?bu="+b+"&base="+document.getElementById("base").value;
}
function changeDivision(b) {
  //document.location = "editNews.asp?base="+b+"&bu="+document.getElementById("bu").value;
}
</script>
<center>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:20px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:14px;color:#737579;">Update Bulletins</span></td></tr>
</table>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr><td align="center"><span class="fonts1" style="font-weight:bold;font-size:11px;">
            <select style="width:305px;" id="division" name="division" onchange="changeDivision(this.value)">
              <option value="">select division</option>
              <option value="all">All</option>
<%
sql = "select division, code from division_t order by division asc"
set rs = conn_asap.execute(sql)
do while not rs.eof
%>
              <option value="<%= rs("code") %>"><%= rs("division") %></option>
<%
  rs.movenext
loop
%>
            </select>
            <script>document.getElementById("division").value = "<%= code %>";</script>
  </td></tr>
</table>

<% if(len(msg) > 0) then %>
<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:5px;margin-left:10px;">
  <tr><td align="center"><span class="fonts4" style="font-size:10px;color:red;font-weight:bold;"><%= msg %></span></td></tr>
</table>
<% end if %>

<table border="0" cellspacing="0" cellpadding="0" width="550" style="padding-top:15px;margin-left:10px;">
  <tr><td align="center"><img src="images/1pgrey.gif" width="370" height="1"></td></tr>
</table>


<div style="margin-top:5px;margin-bottom:10px;">
<%
Dim oFCKeditor
Set oFCKeditor = New FCKeditor
oFCKeditor.BasePath = "/fckeditor2/"
oFCKeditor.ToolbarSet = "Default"
oFCKeditor.Width  = "800"
oFCKeditor.Height = "500"
oFCKeditor.Value = news
oFCKeditor.Create "news"
%>
<div><input type="submit" value="update"></div>
</div>


<!--#include file ="includes/footer.inc"-->

</center>
</form>
</body>
</html>