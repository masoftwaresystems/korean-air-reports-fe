
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<%
recid		= request("recid")

sql = "select * from EHD_Attachments where recid = "& sqlnum(recid)
set rs = conn_asap.execute(sql)
if not rs.eof then
  filename = rs("file_name")
  size = rs("size")
end if


Response.Buffer = FALSE
Response.ContentType = "application/octet-stream"
Response.AddHeader "Content-Length", size
Response.AddHeader "pragma", "no-cache"
Response.AddHeader "cache-control", "no-cache, private, must-revalidate"
Response.AddHeader "content-disposition","attachment; filename="& filename

'GetImageData = rs("file_data").GetChunk(rs("file_data").ActualSize)

filedata = rs("file_data")
Response.BinaryWrite chrb(rs("file_data"))
%>