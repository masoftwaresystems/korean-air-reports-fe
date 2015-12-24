<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/security.inc" -->
<!--#include file="includes/dbcommon_asap.inc"-->
<%
division = request("division")

sql = "select * from BULLET_INFO_T where REPORTER = "& sqltext2(division)
set rs=conn_asap.execute(sql)
if not rs.eof then
  news = rs("SUBJECT")
end if

%>
<html>
<head>
<!--#INCLUDE virtual ="/fckeditor2/fckeditor.asp" -->
</head>
<body>
<form name="frm" id="frm" action="updateNews.asp" method="post">
<input type="hidden" name="division" value="<%= division %>">
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
<center>
<div><input type="submit" value="update"> <input type="button" value="close" onclick="window.close()"></div>
</center>
</form>
<% if(request("rc") = "1") then %>
<script>
alert("Updated");
</script>
<% end if %>
</body>
</html>