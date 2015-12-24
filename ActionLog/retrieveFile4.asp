<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<%
recid		= request("recid")

sql = "select * from EHD_Attachments where recid = "& sqlnum(recid)
set rs = conn_asap.execute(sql)
if not rs.eof then
  filename = rs("file_name")
  filesize = rs("size")
  'filedata = rs("file_data")
end if

Response.ContentType = "application/octet-stream"

Dim strFilePath
Const CHUNK = 2048
Const adTypeBinary = 1
'strFilePath = "C:\Inetpub\wwwroot\downloads\DELTA9617.wav"
Set objStream = Server.CreateObject("ADODB.Stream")
objStream.Open
objStream.Type = adTypeBinary
'objStream.LoadFromFile strFilePath
objStream.Write rs("file_data")
objStream.Position = 0

Response.AddHeader "pragma", "no-cache"
Response.AddHeader "cache-control", "no-cache, private, must-revalidate"
Response.AddHeader "Content-Length", objStream.Size
Response.AddHeader "content-disposition","attachment; filename="& filename
Response.Buffer = False
Do Until objStream.EOS Or Not Response.IsClientConnected
Response.BinaryWrite(objStream.Read(CHUNK))
Loop

objStream.Close
%>