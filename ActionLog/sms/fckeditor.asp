<html>
<head>
<!--#INCLUDE virtual ="/fckeditor2/fckeditor.asp" -->
</head>
<body>
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
</body>
</html>