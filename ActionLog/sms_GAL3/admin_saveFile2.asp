<%
'###############################################
'#
'# admin_saveFile2.asp
'#
'# Save uploaded attachment for iSRT log
'#
%>
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<%
response.buffer = true 'in my tests, this seems to increase speed a bit
%>
<%
'###############################################
'# Windows Upload dll object instantiation
'#
%>
<%
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

log_number		= oUpload.Form("log_number")
log_number		= string(4-len(log_number),"0")&log_number
viewDivision	= oUpload.Form("viewDivision")

%>
<%
'###############################################
'# Manipulation of original and changed filename
'#
%>
<%

originalfilename			= oUpload.FileName
fileextension				= ucase(right(oUpload.FileName,3))

newfilename = replace(viewDivision,":","") & log_number &"_"& strDate &"."& fileextension

oUpload.FileName = newfilename
oUpload.Save

'response.write("log number:"& log_number)
'response.end

Const adTypeBinary = 1

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


%>
<%
'###############################################
'# Add record for uploaded file
'#
%>
<%
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
fRS("archived") = "n"
fRS("attach_size") = BinaryStream.Size

fRS.Update

location = "admin_Attachments.asp?log_number="& log_number &"&viewdivision="& viewdivision

response.redirect(location)
response.end
%>
