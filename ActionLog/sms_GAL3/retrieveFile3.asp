<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include virtual ="/global_includes/contentTypes.inc"-->
<%
if(Request.ServerVariables("HTTPS") = "on") then
  Response.Redirect "http://www2.bristowsafety.com/sms_BAD/retrieveFile3.asp?recid="& request("recid")
  Response.end
end if
%>
<%
recid		= request("recid")

sql = "select * from EHD_Attachments where recid = "& sqlnum(recid)
set rs = conn_asap.execute(sql)
if not rs.eof then
  filename = rs("file_name")
  filesize = rs("size")
  real_file_name = rs("real_file_name")
  'filedata = rs("file_data")
end if

Set bin = CreateObject("ADODB.Stream")
bin.Type = adTypeBinary
bin.Open
bin.LoadFromFile Server.MapPath("./attachments/"&real_file_name)
ReadByteArray = bin.Read

Response.AddHeader "content-disposition","attachment; filename="& filename
Response.BinaryWrite ReadByteArray

response.end

Dim strFilePath
Const CHUNK = 2048
Const adTypeBinary = 1
Set objStream = Server.CreateObject("ADODB.Stream")
objStream.Open
objStream.Type = adTypeBinary
'objStream.LoadFromFile strFilePath
objStream.Write rs("file_data")
objStream.Position = 0

filenameArr = split(filename,".")
ext = filenameArr(ubound(filenameArr))
mime = oMIME.Item(ext)

'response.write(mime)
'response.end

Response.ContentType = mime
'Response.ContentType = "application/pdf"

'Response.AddHeader "pragma", "no-cache"
'Response.AddHeader "cache-control", "no-cache, private, must-revalidate"
'Response.AddHeader "Content-Length", objStream.Size
Response.AddHeader "content-disposition","attachment; filename="& filename
'Response.Buffer = False
Do Until objStream.EOS Or Not Response.IsClientConnected
Response.BinaryWrite(objStream.Read(CHUNK))
Loop

objStream.Close
%>
