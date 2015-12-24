<!--#include virtual="/global_includes/nocache.inc"-->
<!--#include virtual="/global_includes/dbcommon.inc"-->
<!--#include virtual="/global_includes/xmlUtils.inc"-->
<!--#include file="includes/commonUtils.inc" -->
<!--#include file="includes/dbcommon_asap.inc"-->
<%
response.buffer = true 'in my tests, this seems to increase speed a bit

set oUpload = server.createobject("Persits.Upload")

filecnt = oUpload.Save

log_number							= oUpload.Form("log_number")
viewDivision						= oUpload.Form("viewDivision")


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

if (filecnt > 0) then

    Set File = oUpload.Files(1)

    tmpfilenameArr  = split(File.OriginalFileName,".")
    fileextension = tmpfilenameArr(ubound(tmpfilenameArr))

  hazard_number = string(4-len(hazard_number),"0") & hazard_number
  hazard_id = viewDivision &"-"& hazard_number

    newfilename = hazard_id &"_"& strDate &"."& fileextension

    File.SaveAs Server.MapPath("./attachments") &"/"& newfilename

Const adTypeBinary = 1

'Create Stream object
Dim BinaryStream
Set BinaryStream = CreateObject("ADODB.Stream")

'Specify stream type - we want To get binary data.
BinaryStream.Type = 1

'Open the stream
BinaryStream.Open

'response.write(newfilename)
'response.end

'Load the file data from disk To stream object
BinaryStream.LoadFromFile Server.MapPath("./attachments/"&newfilename)

'Open the stream And get binary data from the object
ReadBinaryFile = BinaryStream.Read

Const adLockOptimistic = 3

maxid = 0
sql = "select nvl(max(recid),0) maxid from EHD_Attachments"
set rs = conn_asap.execute(sql)
if not rs.eof then
  maxid = rs("maxid")
end if
maxid = cint(maxid) +1


  linkStr = "<a href='/attachments/"& newfilename &"' target='_new'><span decode>"& File.OriginalFileName &"</span></a>"

  'response.write(linkStr)
  'response.end

  sql = "select nvl(max(recid),0) maxid from EHD_Comments"
  set rs = conn_asap.execute(sql)
  if not rs.eof then
    maxid = rs("maxid")
  end if
  maxid = cint(maxid) +1

  Set cmn5= Server.CreateObject("ADODB.Command")
  Set cmn5.ActiveConnection = conn_asap

  cmn5.CommandText = "insert into EHD_Comments(recid, loginID, item_commentXML, comment_type, log_number, division, comment_ehd, COMMENT_DATE) values (?,?,?,?,?,?,?, current_date)"
  cmn5.Prepared = True

  cmn5.Parameters.Append cmn5.CreateParameter("recid",3)
  cmn5.Parameters.Append cmn5.CreateParameter("loginID",3)
  cmn5.Parameters.Append cmn5.CreateParameter("item_commentXML",201, ,len(linkStr)+100)
  cmn5.Parameters.Append cmn5.CreateParameter("comment_type",200, ,len("attachments") )
  cmn5.Parameters.Append cmn5.CreateParameter("log_number",3)
  cmn5.Parameters.Append cmn5.CreateParameter("division",200, ,len(viewDivision))
  cmn5.Parameters.Append cmn5.CreateParameter("comment_ehd",200, ,1)

  c = replace("<data><link><![CDATA["& linkStr &"]]></link></data>","&","&amp;")


  cmn5("recid") = maxid
  cmn5("loginID") = session_loginID
  cmn5("item_commentXML") = c
  cmn5("comment_type") = "attachments"
  cmn5("log_number") = log_number
  cmn5("division") = viewDivision
  cmn5("comment_ehd") = " "

  cmn5.Execute

  'SQL = "INSERT INTO EHD_Attachments(file_data, recid, log_number, division, file_name, real_file_name, archived, create_date) VALUES(?, "
  'SQL = SQL & maxid & ", "
  'SQL = SQL & log_number & ", '"
  'SQL = SQL & viewDivision & "', '"
  'SQL = SQL & File.OriginalFileName & "', '"
  'SQL = SQL & newfilename & "', 'n',COMMENT_DATE)"
  'File.ToDatabase conn_asap, SQL

'SQL = "Select * from EHD_Attachments Where 1=0"
'Set fRS = CreateObject("ADODB.Recordset")
'fRS.Open SQL, conn_asap, adOpenKeyset, adLockOptimistic, adCmdText
'fRS.AddNew
'fRS("recid") = cint(maxid)
'fRS("log_number") = cint(log_number)
'fRS("division") = viewDivision
'fRS("file_data") = ReadBinaryFile
'fRS("file_name") = File.OriginalFileName
'fRS("real_file_name") = newfilename
'fRS("archived") = "n"
'fRS("create_date") = now()
'fRS.Update


end if

location = "divisional_Attachments.aspx?log_number="& log_number &"&viewdivision="& viewdivision

response.redirect(location)
response.end
%>
