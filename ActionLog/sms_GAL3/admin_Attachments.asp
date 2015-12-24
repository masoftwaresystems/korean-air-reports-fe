<%
'###############################################
'# admin_Attachments.asp
'#
'# Interface to show and upload attachments to the iSRT area
'#
%>
<!--#INCLUDE FILE = "includes/security.inc" -->
<!--#include virtual ="/global_includes/nocache.inc"-->
<!--#include virtual ="/global_includes/dbcommon.inc"-->
<!--#include virtual ="/global_includes/dbcommon_asap2.inc"-->
<!--#include virtual ="/global_includes/xmlUtils.inc"-->
<!--#include file ="includes/wrapformdata2.inc"-->
<html><head>
<!--#include file ="includes/commonhead.inc"-->
<%
log_number		= request("log_number")
viewDivision	= request("viewDivision")

if(len(log_number) < 5) then
  log_numberStr	= string(4-len(log_number),"0")&log_number
else
  log_numberStr = log_number
end if

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
%>
<%
'###############################################
'# Dynamic menu
'#
%>
     <link href="css/style.css" rel="stylesheet" type="text/css" />
 <!--#include file="script/nav.js"-->
<style>
</style></head>
<body bottomMargin="3" bgColor="#ffffff" leftMargin="3" topMargin="3" rightMargin="3">
       <div id="headerDiv">
 <!--#include file="includes/sms_header.inc"-->
      </div>
<center>
<br></br>
<form action="admin_saveFile2.asp" method="post" name="frm" id="frm" enctype="multipart/form-data" >

<input type="hidden" id="log_number" name="log_number" value="<%= log_number %>">
<input type="hidden" id="viewDivision" name="viewDivision" value="<%= viewDivision %>">
<input type="hidden" id="strDate" name="strDate" value="<%= strDate %>">

<table style="BORDER-RIGHT: 1px; PADDING-RIGHT: 3px; BORDER-TOP: 1px; PADDING-LEFT: 3px; PADDING-BOTTOM: 3px; BORDER-LEFT: 1px; PADDING-TOP: 3px; BORDER-BOTTOM: 1px; BACKGROUND-COLOR: #ffffff" cellSpacing="0" cellPadding="1" width="100%">
<tr><td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: #000040; FONT-FAMILY: Arial" align="center" width="10%" background="" bgColor="#ffffff">
&nbsp;
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 14pt; COLOR: navy; FONT-FAMILY: Arial" align="center" width="80%" background="" bgColor="#ffffff"><span style="color:black;font-size:15px;font-weight:bold;">Attachments: Log Number <%= viewDivision %><%= log_numberStr %></span>
</td>
<td style="FONT-WEIGHT: normal; FONT-SIZE: 8pt; COLOR: navy; FONT-FAMILY: Arial" align="right" width="10%" background="" bgColor="#ffffff">

</td>
</tr>
</table>

<%
'###############################################
'# List current uploaded documents
'#
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:30px;">
<%
sql = "select * from EHD_Attachments where log_number = "& sqlnum(log_number) &" and division = "& sqltext2(viewDivision) &" and archived = 'n' order by recid desc"
set rs = conn_asap.execute(sql)
do while not rs.eof
  file_name		= rs("file_name")
  recid			= rs("recid")
  division		= rs("division")
  file_size		= rs("attach_size")
%>
  <tr>
    <td align="right" width="40%"></td>
    <td align="left" width="60%" style="font-size:11px;"><input type="button" value="delete" style="font-size:9px;width:50px;margin-right:5px;" onclick="document.location='admin_deleteFile.asp?recid=<%= recid %>&log_number=<%= log_number %>&viewDivision=<%= viewDivision %>'"><span class="fonts1" style="padding-right:5px;"><a href="retrieveFile3.asp?recid=<%= recid %>" target="_blank"><%= file_name %>&nbsp;-&nbsp;<%= file_size %>&nbsp;bytes</a></span></td>
  </tr>
<%
  rs.movenext
loop
%>
</table>

<%
'###############################################
'# Upload form
'#
%>
<table border="0" cellpadding="0" cellspacing="0" width="100%" style="margin-top:30px;">
  <tr>
    <td align="right" width="40%"><span class="fonts1" style="padding-right:5px;">Select File : </span></td>
    <td align="left" width="60%"><input name="filename" id="filename" type="file" class="input1" style="width:400px;"></td>
  </tr>
  <tr>
    <td align="right" ><span class="fonts1" style="padding-right:5px;">&nbsp;</span></td>
    <td align="left" ><input type="submit" value="Upload Attachment" style="font-size:10px;width:160px;margin-top:5px;margin-left:0px;" ><input type="button" value="Return To Log Input" style="font-size:10px;width:160px;margin-top:5px;margin-left:0px;" onclick="document.location='admin_LogInput.asp?log_number=<%= log_number %>&viewDivision=<%= viewDivision %>'"><br><input type="button" value="Return To Action Log" style="font-size:10px;width:160px;margin-top:1px;margin-left:0px;" onclick="document.location='admin_LogDisplay.asp?viewDivision=<%= viewDivision %>'"></td>
  </tr>
</table>


</form>

<!--#include file ="includes/footer.inc"-->
</body>
</html>





