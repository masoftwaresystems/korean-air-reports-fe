<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<%
response.buffer = true 'in my tests, this seems to increase speed a bit

set oUpload = server.createobject("ASPUpLoad.clsUpload")
oUpload.Path = Server.MapPath("./attachments")

d    = day(now())
mon  = month(now())
yr   = year(now())
hr   = hour(now())
min  = minute(now())
sec  = second(now())
if(len(d) = 1) then
  d = "0"& d
end if
if(len(mon) = 1) then
  mon = "0"& mon
end if
if(len(hr) = 1) then
  hr = "0"& hr
end if
if(len(min) = 1) then
  min = "0"& min
end if
if(len(sec) = 1) then
  sec = "0"& sec
end if

strDate = yr & mon & d & hr & min & sec

originalfilename			= oUpload.FileName
fileextension				= ucase(right(oUpload.FileName,3))

newfilename = "A"& log_number &"_"& strDate &"."& fileextension

oUpload.FileName = newfilename
if oUpload.Save then
  'response.write("originalfilename:"& originalfilename &"<br>")
  'response.write("newfilename:"& newfilename &"<br>")
else
  'response.write "File save failed for the following reason: " &  oUpload.Error
end if

'seq_nbr			= oUpload.Form("seq_nbr")
'acct_code			= oUpload.Form("acct_code")

log_number		= oUpload.Form("log_number")
log_number		= string(4-len(log_number),"0")&log_number
viewDivision	= oUpload.Form("viewDivision")

'response.write("log number:"& log_number)
'response.end


'response.end

Const adTypeBinary = 1

'fileName = "C0002822.PDF"

'Create Stream object
Dim BinaryStream
Set BinaryStream = CreateObject("ADODB.Stream")

'Specify stream type - we want To get binary data.
BinaryStream.Type = 1

'Open the stream
BinaryStream.Open

'Load the file data from disk To stream object
BinaryStream.LoadFromFile Server.MapPath("./attachments/"&newfilename)

'Open the stream And get binary data from the object
ReadBinaryFile = BinaryStream.Read

Const adLockOptimistic = 3

SQL = "Select * from EHD_Attachments Where 1=0"

'Set Conn3 = connusi
Set fRS = CreateObject("ADODB.Recordset")
fRS.Open SQL, conn_asap, adOpenKeyset, adLockOptimistic, adCmdText

fRS.AddNew

fRS("log_number") = cint(log_number)
fRS("division") = viewDivision
fRS("file_data") = ReadBinaryFile
fRS("file_name") = originalfilename
fRS("real_file_name") = newfilename

fRS.Update

'AddBinaryDataRowID = fRS("recid")
'response.write(AddBinaryDataRowID)

'Set objFSO = CreateObject("Scripting.FileSystemObject")
'objFSO.DeleteFile Server.MapPath("./attachments/"& newfilename)

location = "iEHD_Attachments.asp?log_number="& log_number

response.redirect(location)
response.end
%>
